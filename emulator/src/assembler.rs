mod parser;

use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;

use crate::assembler::parser::*;

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
        match parse_line(line.as_bytes()) {
            Ok((_, inst)) => Some(inst),
            Err(_) => None
        }
    }
}