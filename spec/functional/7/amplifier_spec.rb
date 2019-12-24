# frozen_string_literal: true

RSpec.describe Intcode::Computer do
  context 'puzzles' do
    let(:program_text) { File.read('7/input.txt') }

    it 'solves part 1' do
      phase_settings = 0.upto(4).to_a
      perms = phase_settings.permutation.to_a

      max = 0
      max_sequence = []
      perms.each do |sequence|
        input_signal = 0
        sequence.each do |setting|
          computer = Intcode::Computer.new(program_text)
          computer.add_input(setting)
          computer.add_input(input_signal)
          computer.run do |output|
            input_signal = output
          end
        end
        if input_signal > max
          max = input_signal
          max_sequence = sequence
        end
      end

      expect(max).to eq(422_858)
      expect(max_sequence).to contain_exactly(3, 1, 4, 2, 0)
    end

    it 'solves part 2', slow: true do
      phase_settings = 5.upto(9).to_a
      perms = phase_settings.permutation.to_a

      max = 0
      max_sequence = []
      perms.each do |sequence|

        computer_a = Intcode::Computer.new(program_text)
        computer_a.add_input(sequence[0])
        computer_a.add_input(0)

        computer_b = Intcode::Computer.new(program_text)
        computer_b.add_input(sequence[1])

        computer_c = Intcode::Computer.new(program_text)
        computer_c.add_input(sequence[2])

        computer_d = Intcode::Computer.new(program_text)
        computer_d.add_input(sequence[3])

        computer_e = Intcode::Computer.new(program_text)
        computer_e.add_input(sequence[4])

        until computer_a.finished? && computer_b.finished? && computer_c.finished? && computer_d.finished? && computer_e.finished?
          unless computer_a.finished?
            computer_a.run do |output|
              computer_b.add_input(output)
            end
          end

          unless computer_b.finished?
            computer_b.run do |output|
              computer_c.add_input(output)
            end
          end

          unless computer_c.finished?
            computer_c.run do |output|
              computer_d.add_input(output)
            end
          end

          unless computer_d.finished?
            computer_d.run do |output|
              computer_e.add_input(output)
            end
          end

          next if computer_e.finished?

          computer_e.run do |output|
            computer_a.add_input(output)
          end
        end

        result = computer_a.input_buffer.first
        if result > max
          max = result
          max_sequence = sequence
        end
      end
      expect(max).to eq(14_897_241)
      expect(max_sequence).to contain_exactly(7, 8, 9, 6, 5)
    end
  end
end
