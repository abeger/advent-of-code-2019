# frozen_string_literal: true

RSpec.describe Intcode::Computer do
  context 'examples' do
    def run_program(program_text, expected_result)
      result = Intcode::Computer.new(program_text).run
      expect(result).to eq(expected_result)
    end

    it 'handles example program 1' do
      program_text = '1,9,10,3,2,3,11,0,99,30,40,50'
      run_program(program_text, 3500)
    end

    it 'handles example program 2' do
      program_text = '1,0,0,0,99'
      run_program(program_text, 2)
    end

    it 'handles example program 3' do
      program_text = '1,1,1,4,99,5,6,0,99'
      run_program(program_text, 30)
    end
  end

  context 'puzzles' do
    let(:program_text) { File.read('02/input.txt') }

    it 'finds the correct solution to part 1' do
      result = Intcode::Computer.new(program_text).run(12, 2)
      expect(result).to eq(12_490_719)
    end

    it 'finds the correct solution to part 2' do
      result = Intcode::Computer.new(program_text).run(20, 3)
      expect(result).to eq(19_690_720)
    end
  end
end
