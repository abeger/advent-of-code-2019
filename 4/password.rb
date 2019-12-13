# frozen_string_literal: true

if ARGV.count < 2
  puts 'Usage: ruby password.rb <low_val> <high_val>'
  exit
end

low_val = ARGV[0]
high_val = ARGV[1]

def contains_double_digit(password)
  password =~ /(.)\1/
end

def ascending_digits(password)
  # get every pair, compare
  password.chars.each_cons(2) do |arr|
    return false if arr[1] < arr[0]
  end
  true
end

def validate_password?(password)
  return false unless password.length == 6

  return false unless contains_double_digit(password)

  return false unless ascending_digits(password)

  true
end

passwords = (low_val..high_val).select do |val|
  validate_password?(val.to_s)
end

puts "#{passwords.count} valid passwords"
