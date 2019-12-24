# frozen_string_literal: true

RSpec.describe Intcode::Computer do
  describe '#input' do
    it 'receives an input directly from the user' do
      computer = Intcode::Computer.new('', :manual)
      expect(STDIN).to receive(:gets).and_return("23\n")
      expect do
        expect(computer.input).to eq(23)
      end.to output('Enter input: ').to_stdout
    end
  end

  describe '#add_input' do
    it 'buffers an input' do
      computer = Intcode::Computer.new('', :auto)
      computer.add_input(14)
      expect(computer.input).to eq(14)
    end
  end

  describe '#input?' do
    it 'returns false for an empty input buffer' do
      computer = Intcode::Computer.new('')
      expect(computer.input?).to eq(false)
    end

    it 'returns true if input is buffered' do
      computer = Intcode::Computer.new('')
      computer.add_input(32)
      expect(computer.input?).to eq(true)
    end
  end

  describe '#output' do
    it 'outputs data to stdout' do
      computer = Intcode::Computer.new('')
      expect do
        computer.output(23)
      end.to output("23\n").to_stdout
    end

    it 'passes output to a passed-in proc' do
      computer = Intcode::Computer.new('')
      output_value = nil
      computer.output_block = proc { |out| output_value = out }
      computer.output(45)
      expect(output_value).to eq(45)
    end
  end
end
