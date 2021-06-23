# XOR decryption
# Submit

#  Show HTML problem content 
# Problem 59
# Each character on a computer is assigned a unique code and the preferred 
# standard is ASCII (American Standard Code for Information Interchange). For 
# example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

# A modern encryption method is to take a text file, convert the bytes to 
# ASCII, then XOR each byte with a given value, taken from a secret key. The 
# advantage with the XOR function is that using the same encryption key on the 
# cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107 
# XOR 42 = 65.

# For unbreakable encryption, the key is the same length as the plain text 
# message, and the key is made up of random bytes. The user would keep the 
# encrypted message and the encryption key in different locations, and without 
# both "halves", it is impossible to decrypt the message.

# Unfortunately, this method is impractical for most users, so the modified 
# method is to use a password as a key. If the password is shorter than the 
# message, which is likely, the key is repeated cyclically throughout the 
# message. The balance for this method is using a sufficiently long password 
# key for security, but short enough to be memorable.

# Your task has been made easy, as the encryption key consists of three lower 
# case characters. Using p059_cipher.txt (right click and 'Save Link/Target 
# As...'), a file containing the encrypted ASCII codes, and the knowledge that 
# the plain text must contain common English words, decrypt the message and 
# find the sum of the ASCII values in the original text.

numbers = open("../input/euler59.txt").read.chomp.split(',').map(&:to_i)
p numbers.length
keys = ('aaa'..'zzz') # I just discovered you could do this.

def decode(numbers, key)
  result = ""
  numbers.each_with_index do |n, i|
    result += (n ^ key[i % 3].ord).chr
  end
  result
end

# bs = "{[]}`<>".split("")
common = [" is ", " a ", "an ", "from ", " the ", " of "]
for key in keys
  message = decode(numbers, key).downcase
  p [key, message] if common.all? {|c| message.include?(c)}
end