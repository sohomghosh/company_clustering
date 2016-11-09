import re
fp1=open("company-clusters-sample.txt",'r') #As new company names and cluster id needs to be appended
fp2=open("unmapped-sample.txt",'r') 
fp3=open("company-clusters-sample-preprocessed.csv",'w')
fp4=open("unmapped-sample-preprocessed.csv",'w')
fp3.write("Company_name,Cluster_id\n")
fp4.write("Company_name\n")
for line1 in fp1:
	tk1=line1.split('  ')
	a=str(tk1[1])[:-1].lower()
	a_new=''.join(e for e in a if e.isalnum()) #Removing special characters and spaces from the company name
	#print a_new
	b_new=tk1[0]
	fp3.write(str(a_new)+","+str(b_new)+"\n")
	
for line2 in fp2:
	tk2=re.split('[0-9][ ]',str(line2))
	a2=str(tk2[1])[:-1].lower()
	a2_new=''.join(e for e in a2 if e.isalnum()) #Removing special characters and spaces from the company name
	fp4.write(str(a2_new)+"\n")
#append_extra company names to fp2 and fp4
fp1.close()
fp2.close()
fp3.close()
fp4.close()