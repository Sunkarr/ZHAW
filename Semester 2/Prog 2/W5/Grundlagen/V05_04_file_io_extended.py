import os

file_name = 'myfile.txt'

fw = open(file_name, 'w')
print("Name of the file: ", fw.name)

# write to the file stream
fw.write('hello')
fw.write('world')
print('\nwrite this in the file', file=fw)

# fw.flush() # flushes the internal buffer

fr = open(file_name)
fr.seek(0)
print(fr.read())

fw.close()
fr.close()

if os.path.exists(file_name):
  os.remove(file_name)
else:
  print("The file does not exist")

