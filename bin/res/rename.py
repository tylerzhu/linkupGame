import os
path = 'images/'
i = 1
for file in os.listdir(path):
	if os.path.isfile(os.path.join(path,file))==True:
		print(os.path.join(path,"heroes_"+str(i)+".jpg"))
		os.rename(os.path.join(path,file),os.path.join(path,"heroes_"+str(i)+".jpg"))
		i = i+1
		print(file)