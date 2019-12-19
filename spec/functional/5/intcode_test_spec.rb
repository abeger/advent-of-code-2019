# frozen_string_literal: true

RSpec.describe Intcode::Computer do
  def run_program(program_text, input, expected_result)
    computer = Intcode::Computer.new(program_text)
    expect(computer).to receive(:input).and_return(input)
    expect(computer).to receive(:output).with(expected_result)
    computer.run
  end

  context 'comparison examples' do
    context 'using position mode and equals' do
      let(:program_text) { '3,9,8,9,10,9,4,9,99,-1,8' }

      it 'returns 1 if input equals 8' do
        run_program(program_text, 8, 1)
      end

      it 'returns 0 if input does not equal 8' do
        run_program(program_text, 7, 0)
      end
    end

    context 'using position mode and less than' do
      let(:program_text) { '3,9,7,9,10,9,4,9,99,-1,8' }

      it 'returns 1 if input less than 8' do
        run_program(program_text, 5, 1)
      end

      it 'returns 0 if input is not less than 8' do
        run_program(program_text, 9, 0)
      end
    end

    context 'using immediate mode and equals' do
      let(:program_text) { '3,3,1108,-1,8,3,4,3,99' }

      it 'returns 1 if input equals 8' do
        run_program(program_text, 8, 1)
      end

      it 'returns 0 if input does not equal 8' do
        run_program(program_text, 7, 0)
      end
    end

    context 'using immediate mode and less than' do
      let(:program_text) { '3,3,1107,-1,8,3,4,3,99' }

      it 'returns 1 if input less than 8' do
        run_program(program_text, 5, 1)
      end

      it 'returns 0 if input is not less than 8' do
        run_program(program_text, 9, 0)
      end
    end
  end

  context 'jump examples' do
    context 'position mode' do
      let(:program_text) { '3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9' }

      it 'returns 1 if input is nonzero' do
        run_program(program_text, 5, 1)
      end

      it 'returns 0 if input is zero' do
        run_program(program_text, 0, 0)
      end
    end

    context 'immediate mode' do
      let(:program_text) { '3,3,1105,-1,9,1101,0,0,12,4,12,99,1' }

      it 'returns 1 if input is nonzero' do
        run_program(program_text, 5, 1)
      end

      it 'returns 0 if input is zero' do
        run_program(program_text, 0, 0)
      end
    end
  end

  context 'larger example' do
    let(:program_text) do
      <<~PROGRAM
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
      PROGRAM
    end

    it 'returns 999 if value < 8' do
      run_program(program_text, 7, 999)
    end

    it 'returns 1000 if value == 8' do
      run_program(program_text, 8, 1000)
    end

    it 'returns 1001 if value > 8' do
      run_program(program_text, 9, 1001)
    end
  end

  context 'puzzles' do
    let(:program_text) { File.read('5/input.txt') }

    it 'solves part 1' do
      computer = Intcode::Computer.new(program_text)
      expect(computer).to receive(:input).and_return(1)
      expect(computer).to receive(:output).with(0).exactly(9).times.ordered
      expect(computer).to receive(:output).with(16_434_972).once.ordered
      computer.run
    end

    it 'solves part 2' do
      run_program(program_text, 5, 16_694_270)
    end
  end
end
