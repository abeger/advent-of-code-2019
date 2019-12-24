# frozen_string_literal: true

RSpec.describe Intcode::Computer do
  context 'examples' do
    it 'handles example 1' do
      program = '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'
      computer = described_class.new(program)
      output_array = []
      computer.run do |output|
        output_array << output
      end
      expect(output_array.join(',')).to eq(program)
    end

    it 'handles example 2' do
      program = '1102,34915192,34915192,7,4,7,99,0'
      computer = described_class.new(program)
      computer.run do |output|
        expect(output).to eq(1_219_070_632_396_864)
      end
    end

    it 'handles example 3' do
      program = '104,1125899906842624,99'
      computer = described_class.new(program)
      computer.run do |output|
        expect(output).to eq(1_125_899_906_842_624)
      end
    end
  end

  context 'puzzles' do
    let(:program_text) { File.read('9/input.txt') }

    it 'solves part 1' do
      computer = Intcode::Computer.new(program_text)
      computer.add_input(1)
      computer.run do |output|
        expect(output).to eq(2_932_210_790)
      end
    end
  end
end
