use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;

use crate::command::*;

pub struct Assembler {
    reader: BufReader<File>,
}

impl Assembler {
    pub fn new(path: &str) -> Self {
        let f = File::open(path).expect("cannot open file");
        let reader = BufReader::new(f);
        Assembler {
            reader
        }
    }

    pub fn assemble_line(&mut self) -> Option<u16> {
        let mut line = String::new();
        let _size = self.reader.read_line(&mut line);
        let iter_cmd = &mut line.split_whitespace();
        let cmd = if let Some(c) = iter_cmd.next() {
            Command::from_str(c)
        } else {
            return None; // eof or empty line
        };
        let inst = match cmd {
            Command::Mov | Command::Add | Command::Sub |
            Command::And | Command::Or  | Command::Cmp => {
                let reg_a = iter_cmd.next().unwrap();
                let reg_b = iter_cmd.next().unwrap();
                let id_a = reg_a.chars().nth(3).unwrap().to_digit(10).unwrap() as u16;
                let id_b = reg_b.chars().nth(3).unwrap().to_digit(10).unwrap() as u16;
                (cmd as u16) << 11 | id_a << 8 | id_b << 5
            },
            Command::Sl | Command::Sr | Command::Sra => {
                let reg_a = iter_cmd.next().unwrap();
                let id_a = reg_a.chars().nth(3).unwrap().to_digit(10).unwrap() as u16;
                (cmd as u16) << 11 | id_a << 8
            },
            Command::Ldl | Command::Ldh | Command::Ld | Command::St => {
                let reg_a = iter_cmd.next().unwrap();
                let data = iter_cmd.next().unwrap().parse::<i16>().unwrap();
                let id_a = reg_a.chars().nth(3).unwrap().to_digit(10).unwrap() as u16;
                (cmd as u16) << 11 | id_a << 8 | data as u16 & 0x00ff
            },
            Command::Je | Command::Jmp => {
                let addr = iter_cmd.next().unwrap().parse::<u16>().unwrap();
                (cmd as u16) << 11 | addr & 0x00ff
            },
            Command::Hlt => {
                (cmd as u16) << 11
            }
        };
        Some(inst)
    }
}
