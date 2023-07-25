pub use nom::{
    combinator::{
        map_res,
        map_parser,
        map,
        opt
    },
    bytes::streaming::tag,
    character::streaming::{
        alpha1,
        oct_digit1,
        digit1,
        multispace0,
        space1
    },
    number::streaming::{
        le_u16,
        le_i16
    },
    sequence::{
        delimited,
        separated_pair,
        preceded,
        terminated
    },
    IResult
};

use crate::command::*;

fn parse_command(input: &[u8]) -> IResult<&[u8], Command> {
    let (input, cmd) = map_res(alpha1, std::str::from_utf8)(input)?;
    Ok((input, Command::from_str(cmd)))
}

fn parse_reg(input: &[u8]) -> IResult<&[u8], u16> {
    map_parser(preceded(tag("Reg"), oct_digit1), le_u16)(input)
}

fn parse_data(input: &[u8]) -> IResult<&[u8], i16> {
    let (input, sign) = opt(tag("-"))(input)?;
    let (input, abs) = map_parser(digit1, le_i16)(input)?;
    let data = match sign {
        Some(_) => -abs,
        None => abs
    };
    Ok((input, data))
}

fn parse_addr(input: &[u8]) -> IResult<&[u8], u16> {
    map_parser(digit1, le_u16)(input)
}

pub fn parse_instruction(input: &[u8]) -> IResult<&[u8], u16> {
    let (input, cmd) = terminated(parse_command, space1)(input)?;
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

pub fn parse_line<'a>(input: &'a [u8]) -> IResult<&'a[u8], u16> {
    delimited(multispace0, parse_instruction, multispace0)(input)
}
