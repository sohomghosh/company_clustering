import re
fp1=open("company-clusters-sample.txt",'r') #As new company names and cluster id needs to be appended
fp2=open("unmapped-sample.txt",'r') 
fp3=open("company-clusters-sample-preprocessed.csv",'w')
fp4=open("unmapped-sample-preprocessed.csv",'w')
fp3.write("Company_name,Cluster_id\n")
fp4.write("Company_name\n")
for line1 in fp1:
	tk1=line1.split('  ')
	aa=str(tk1[1])[:-1].lower()
	a=""
	for s in aa.split():
		s=s.lower()
		if s=="services" or s=="service" or s=="private" or s=='pvt.'or s=='pvt'or s=='pvt.ltd'or s=='pvt.ltd.'or s=='india' or s=='ltd.' or s=='ltd' or s=='limited'or s=='(i)'or s=='(india)':
			s=""
		a=a+s
	a_new=''.join(e for e in a if e.isalnum()) #Removing special characters and spaces from the company name
	b_new=tk1[0]
	fp3.write(str(a_new)+","+str(b_new)+"\n")
for line2 in fp2:
	tk2=re.split('[0-9][ ]',str(line2))
	a22=str(tk2[1])[:-1].lower()
	a2=""
	for s in a22.split():
		s=s.lower()
		if s=="services" or s=="service" or s=="private" or s=='pvt.'or s=='pvt'or s=='pvt.ltd'or s=='pvt.ltd.'or s=='india' or s=='ltd.' or s=='ltd' or s=='limited'or s=='(i)'or s=='(india)':
			s=""
		a2=a2+s
	a2_new=''.join(e for e in a2 if e.isalnum()) #Removing special characters and spaces from the company name
	if len(tk2)>=3:
		a2_new=str(tk2[1])+str(tk2[2])[:-1]
		a2_new=a2_new.lower()
	fp4.write(str(a2_new)+"\n")
#append_extra company names to fp2 and fp4
fp1.close()
fp2.close()
fp3.close()
fp4.close()