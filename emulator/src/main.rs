mod command;
mod assembler;
mod simulator;

use simulator::*;

fn main() {
    let mut sim = Simulator::new();
    sim.run("sum10.asm");
}
