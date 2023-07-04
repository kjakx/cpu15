use crate::command::*;
use crate::assembler::*;

pub struct Simulator {
    pc: u16,
    ir: u16,
    flag_eq: bool,
    opcode: u16,
    a: usize,
    b: usize,
    data: i16, // same as reg_addr
    reg: [u16; 8],
    rom: Vec<u16>,
    ram: Vec<u16>,
}

impl Simulator {
    pub fn new() -> Self {
        Simulator {
            pc: 0,
            ir: 0,
            flag_eq: false,
            opcode: 0,
            a: 0,
            b: 0,
            data: 0,
            reg: [0; 8],
            rom: Vec::with_capacity(256),
            ram: vec![0; 256],
        }
    }

    pub fn run(&mut self, path_asm: &str) {
        self.assemble(path_asm);
        while Command::from_opcode(self.opcode) != Command::Hlt {
            self.fetch(true);
            self.decode();
            self.execute();
            //self.write_back();
        }
        println!("ram[64] = {}", self.ram[64]);
    }

    fn assemble(&mut self, path: &str) {
        let mut asm = Assembler::new(path);
        loop {
            if let Some(inst) = asm.assemble_line() {
                self.rom.push(inst);
            } else {
                break;
            }
        }
    }

    fn fetch(&mut self, debug: bool) {
        self.ir = self.rom[self.pc as usize];
        if debug {
            println!("{:5} {:5x} {:5} {:5} {:5} {:5}", 
                self.pc, self.ir, self.reg[0], self.reg[1], self.reg[2], self.reg[3]);
        }
        self.pc += 1;
    }

    fn decode(&mut self) {
        self.opcode = (self.ir >> 11) & 0x000f;
        self.a = ((self.ir >> 8) & 0x0007) as usize;
        self.b = ((self.ir >> 5) & 0x0007) as usize;
        self.data = (self.ir & 0x00ff) as i16;
    }

    fn execute(&mut self) {
        match Command::from_opcode(self.opcode) {
            Command::Mov => self.mov(),
            Command::Add => self.add(),
            Command::Sub => self.sub(),
            Command::And => self.and(),
            Command::Or  => self.or(),
            Command::Sl  => self.sl(),
            Command::Sr  => self.sr(),
            Command::Sra => self.sra(),
            Command::Ldl => self.ldl(),
            Command::Ldh => self.ldh(),
            Command::Cmp => self.cmp(),
            Command::Je  => self.je(),
            Command::Jmp => self.jmp(),
            Command::Ld  => self.ld(),
            Command::St  => self.st(),
            Command::Hlt => self.hlt(),
        }
    }

    fn mov(&mut self) {
        self.reg[self.a] = self.reg[self.b];
    }

    fn add(&mut self) {
        self.reg[self.a] += self.reg[self.b];
    }

    fn sub(&mut self) {
        self.reg[self.a] -= self.reg[self.b];
    }

    fn and(&mut self) {
        self.reg[self.a] &= self.reg[self.b];
    }

    fn or(&mut self) {
        self.reg[self.a] |= self.reg[self.b];
    }

    fn sl(&mut self) {
        self.reg[self.a] <<= 1;
    }

    fn sr(&mut self) {
        self.reg[self.a] >>= 1;
    }

    fn sra(&mut self) {
        self.reg[self.a] = (self.reg[self.a] as i16 >> 1) as u16;
    }

    fn ldl(&mut self) {
        self.reg[self.a] &= 0xff00;
        self.reg[self.a] |= self.data as u16 & 0x00ff; 
    }

    fn ldh(&mut self) {
        self.reg[self.a] &= 0x00ff;
        self.reg[self.a] |= (self.data as u16 & 0x00ff) << 8;
    }

    fn cmp(&mut self) {
        self.flag_eq = self.reg[self.a] == self.reg[self.b];
    }

    fn je(&mut self) {
        if self.flag_eq {
            self.pc = self.data as u16 & 0x00ff;
            self.flag_eq = false;
        }
    }

    fn jmp(&mut self) {
        self.pc = self.data as u16 & 0x00ff;
    }

    fn ld(&mut self) {
        let addr = (self.data as u16 & 0x00ff) as usize;
        self.reg[self.a] = self.ram[addr];
    }

    fn st(&mut self) {
        let addr = (self.data as u16 & 0x00ff) as usize;
        self.ram[addr] = self.reg[self.a];
    }

    fn hlt(&mut self) {
        () // nothing to do
    }
}
