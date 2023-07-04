#[derive(Copy, Clone, PartialEq)]
pub enum Command {
    Mov = 0,
    Add = 1,
    Sub = 2,
    And = 3,
    Or  = 4,
    Sl  = 5,
    Sr  = 6,
    Sra = 7,
    Ldl = 8,
    Ldh = 9,
    Cmp = 10,
    Je  = 11,
    Jmp = 12,
    Ld  = 13,
    St  = 14,
    Hlt = 15
}

impl Command {
    pub fn from_opcode(opcode: u16) -> Command {
        match opcode {
             0 => Command::Mov,
             1 => Command::Add,
             2 => Command::Sub,
             3 => Command::And,
             4 => Command::Or,
             5 => Command::Sl,
             6 => Command::Sr,
             7 => Command::Sra,
             8 => Command::Ldl,
             9 => Command::Ldh,
            10 => Command::Cmp,
            11 => Command::Je,
            12 => Command::Jmp,
            13 => Command::Ld,
            14 => Command::St,
            15 => Command::Hlt,
            _ => { panic!("Illegal instruction: {}", opcode); }
        }
    }

    pub fn from_str(mne: &str) -> Command {
        match mne {
            "mov" => Command::Mov,
            "add" => Command::Add,
            "sub" => Command::Sub,
            "and" => Command::And,
            "or"  => Command::Or,
            "sl"  => Command::Sl,
            "sr"  => Command::Sr,
            "sra" => Command::Sra,
            "ldl" => Command::Ldl,
            "ldh" => Command::Ldh,
            "cmp" => Command::Cmp,
            "je"  => Command::Je,
            "jmp" => Command::Jmp,
            "ld"  => Command::Ld,
            "st"  => Command::St,
            "hlt" => Command::Hlt,
            _ => { panic!("Illegal instruction: {}", mne); }
        }
    }
}
