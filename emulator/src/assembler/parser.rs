use nom::{
    combinator::map_res,
    bytes::complete::tag,
    character::complete::{
        alpha1,
        multispace0,
        space0,
        space1,
        i16,
        u16
    },
    sequence::{
        delimited,
        separated_pair,
        preceded,
        terminated
    },
    IResult,
};

use crate::command::*;

fn parse_command(input: &[u8]) -> IResult<&[u8], Command> {
    let (input, cmd) = map_res(alpha1, std::str::from_utf8)(input)?;
    Ok((input, Command::from_str(cmd)))
}

fn parse_reg(input: &[u8]) -> IResult<&[u8], u16> {
    preceded(tag("Reg"), u16)(input)
}

fn parse_data(input: &[u8]) -> IResult<&[u8], i16> {
    i16(input)
}

fn parse_addr(input: &[u8]) -> IResult<&[u8], u16> {
    u16(input)
}

fn parse_instruction(input: &[u8]) -> IResult<&[u8], u16> {
    let (input, cmd) = terminated(parse_command, space0)(input)?;
    let (input, inst) = match cmd {
        Command::Mov | Command::Add | Command::Sub |
        Command::And | Command::Or  | Command::Cmp => {
            let (input, (id_a, id_b)) = separated_pair(parse_reg, space1, parse_reg)(input)?;
            let inst = (cmd as u16) << 11 | id_a << 8 | id_b << 5;
            (input, inst)
        },
        Command::Sl | Command::Sr | Command::Sra => {
            let (input, id_a) = parse_reg(input)?;
            let inst = (cmd as u16) << 11 | id_a << 8;
            (input, inst)
        },
        Command::Ldl | Command::Ldh => {
            let (input, (id_a, data)) = separated_pair(parse_reg, space1, parse_data)(input)?;
            let inst = (cmd as u16) << 11 | id_a << 8 | data as u16 & 0x00ff;
            (input, inst)
        },
        Command::Ld | Command::St => {
            let (input, (id_a, addr)) = separated_pair(parse_reg, space1, parse_addr)(input)?;
            let inst = (cmd as u16) << 11 | id_a << 8 | addr & 0x00ff;
            (input, inst)
        },
        Command::Je | Command::Jmp => {
            let (input, addr) = parse_addr(input)?;
            let inst = (cmd as u16) << 11 | addr & 0x00ff;
            (input, inst)
        },
        Command::Hlt => {
            let inst = (cmd as u16) << 11;
            (input, inst)
        }
    };
    Ok((input, inst))
}

pub fn parse_line(input: &[u8]) -> IResult<&[u8], u16> {
    delimited(multispace0, parse_instruction, multispace0)(input)
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn test_parse_command() {
        assert_eq!(parse_command(&b"add"[..]), Ok((&b""[..], Command::Add)));
        assert_eq!(parse_command(&b"sub Reg0 Reg1"[..]), Ok((&b" Reg0 Reg1"[..], Command::Sub)));
    }

    #[test]
    fn test_parse_reg() {
        assert_eq!(parse_reg(&b"Reg0"[..]), Ok((&b""[..], 0_u16)));
        assert_eq!(parse_reg(&b"Reg3"[..]), Ok((&b""[..], 3_u16)));
        assert_eq!(parse_reg(&b"Reg8"[..]), Ok((&b""[..], 8_u16)));
    }

    #[test]
    fn test_parse_data() {
        assert_eq!(parse_data(&b"13487"[..]), Ok((&b""[..], 13487_i16)));
        assert_eq!(parse_data(&b"-335"[..]), Ok((&b""[..], -335_i16)));
        assert_eq!(parse_data(&b"+67"[..]), Ok((&b""[..], 67_i16)));
    }

    #[test]
    fn test_parse_addr() {
        assert_eq!(parse_addr(&b"65"[..]), Ok((&b""[..], 65_u16)));
        assert_eq!(parse_addr(&b"0"[..]), Ok((&b""[..], 0_u16)));
        assert_eq!(parse_addr(&b"64"[..]), Ok((&b""[..], 64_u16)));
    }

    #[test]
    fn test_parse_instruction() {
        assert_eq!(parse_instruction(&b"add Reg2 Reg1"[..]), Ok((&b""[..], 0x0a20)));
        assert_eq!(parse_instruction(&b"sl Reg0"[..]), Ok((&b""[..], 0x2800)));
        assert_eq!(parse_instruction(&b"ldh Reg0 0"[..]), Ok((&b""[..], 0x4800)));
        assert_eq!(parse_instruction(&b"st Reg0 64"[..]), Ok((&b""[..], 0x7040)));
        assert_eq!(parse_instruction(&b"je 13"[..]), Ok((&b""[..], 0x580D)));
        assert_eq!(parse_instruction(&b"hlt"[..]), Ok((&b""[..], 0x7800)));
    }
}
