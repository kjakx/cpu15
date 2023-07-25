mod parser;

//use std::io::prelude::*;
//use std::io::BufReader;
use nom::sequence::delimited;
use nom_bufreader::bufreader::BufReader;
use nom_bufreader::{Error, Parse};
use std::fs::File;

use crate::command::*;
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

    pub fn parse_line<'a>(&'a self, input: &'a [u8]) -> IResult<&'a [u8], u16> {
        delimited(multispace0, parse_instruction, multispace0)(input)
    }

    pub fn assemble_line(&mut self) -> Option<u16> {
        match self.reader.parse(parse_line) {
            Ok(inst) => Some(inst),
            Err(_) => None
        }
    }
}
