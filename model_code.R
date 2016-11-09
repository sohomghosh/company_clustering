#setwd("C:\\Users\\SatyakiBh\\Documents\\GitHub\\company_clustering") #This needs to be changed as per instructions given in _README_first.txt

train<-read.csv("company-clusters-sample-preprocessed.csv",header = T,stringsAsFactors = F)
test<-read.csv("unmapped-sample-preprocessed.csv",header=T,stringsAsFactors = F)
train<-train[!duplicated(train),]
train_org<-train

#Solution-1
th<-c()
for (i in 1:nrow(train)){
  th<-c(th,length(unlist(strsplit(as.character(train[i,1]),""))))
}
#threshold<-th*1.0/nrow(train) #Average of length of all names of the training set
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
#threshold<- Mode(th) #taking mode i.e 15 as threshold, match is very less; If dataset was huge mode should give good result
threshold<-10 #Near to Mode
res<-matrix(0,nrow=nrow(test),ncol=max(train$Cluster_id))
colnames(res)<-c(paste0("Cluster",1:max(train$Cluster_id)))
res<-as.data.frame(res)
clus_nos<-as.data.frame(table(train$Cluster_id))
colnames(clus_nos)<-c("Cluster_id","Frequency")
clus_max_id<-max(as.numeric(train$Cluster_id))
#install.packages("qualV",dependencies = T) #One time process
library("qualV")
vv<-nrow(train)
for (i in 1:nrow(test)){
  comp_name<-as.character(test[i,1])
  str1<-unlist(strsplit(comp_name,""))
  flag<-0
  for (j in 1:vv){
    comp_name_train<-as.character(train[j,1])
    str2<- unlist(strsplit(comp_name_train,""))
    if(j>nrow(train)){
      break
    }
    nu<-LCS(str1,str2)$LLCS #Storing the length of longest common subsequence
                            #Other method is to use stringdist
    if(nu>threshold){
      flag=1
      nu<-nu/clus_nos[as.numeric(train[j,2]),2] #Normalzing it when more number of strings are into one cluster
      res[i,as.numeric(train[j,2])]<-res[i,as.numeric(train[j,2])]+nu
    }
  }
  if(flag==0){
    clus_max_id<-clus_max_id+1
    nm<-as.character(test[i,1])
    train<-rbind(train,c(nm,clus_max_id))
    ss<-paste0("Cluster",clus_max_id)
    res[,ss]<-0
    res[i,clus_max_id]<-1
  }
}

row_sum<-apply(res,MARGIN = 1,sum)
res_norm<-res
for (i in 1:nrow(res)){
  for (j in 1:ncol(res)){
    if(row_sum[i]!=0){
      res_norm[i,j]=res_norm[i,j]/row_sum[i] #Normalizing to add up the probability to 1
    }
  }
}
train_new<-cbind(train[,2],train[,1])
colnames(train_new)<-c("Company_name","Cluster_id")
write.csv(train_new,"updated_company_cluster_sample.csv",row.names=F)
write.csv(res_norm,"cluster_distribution.csv",row.names = F)




####Solution-2
#Designing feature set for train
featr<-c(0:9,letters)
train_fe<-matrix(0,nrow=nrow(train_org),ncol=length(featr))
colnames(train_fe)<-featr
train_fe<-as.data.frame(train_fe)

for (i in 1:nrow(train_org)){
  str<-as.character(train[i,1])
  li<-unlist(strsplit(str,""))
  for(j in 1:length(li)){
    train_fe[i,c(li[j])]=train_fe[i,c(li[j])]+1
  }
}

  
#Designing feature set for test  
featr<-c(0:9,letters)
test_fe<-matrix(0,nrow=nrow(test),ncol=length(featr))
colnames(test_fe)<-featr
test_fe<-as.data.frame(test_fe)

for (i in 1:nrow(test)){
  str<-as.character(test[i,1])
  li<-unlist(strsplit(str,""))
  for(j in 1:length(li)){
    test_fe[i,c(li[j])]=test_fe[i,c(li[j])]+1
  }
}

#Result vector
res1<-matrix(0,nrow=nrow(test_fe),ncol=max(train_org$Cluster_id))
colnames(res1)<-c(paste0("Cluster",1:max(train_org$Cluster_id)))
res1<-as.data.frame(res1)
clus_nos<-as.data.frame(table(train_org$Cluster_id))
colnames(clus_nos)<-c("Cluster_id","Frequency")
clus_max_id<-max(as.numeric(train_org$Cluster_id))

train_org_du<-train_org
cor_th<-.4
#Correlation check
for(i in 1:nrow(test_fe)){
  vec1<-test_fe[i,]
  flag<-0
  for(j in 1:nrow(train_fe)){
    vec2<-train_fe[j,]
    corre<-cor(as.numeric(vec1),as.numeric(vec2))
    if(corre>cor_th){ #.4 would be better as threshold for correlation
      flag=1
      corre<-corre/clus_nos[as.numeric(train_org[j,2]),2] #Normalzing it when more number of strings are into one cluster
      res1[i,as.numeric(train_org[j,2])]<-res1[i,as.numeric(train_org[j,2])]+corre
    }
  }
  if(flag==0){
    clus_max_id<-clus_max_id+1
    nm<-as.character(test[i,1])
    train_org_du<-rbind(train_org_du,c(nm,clus_max_id))
    ss<-paste0("Cluster",clus_max_id)
    res1[,ss]<-0
    res1[i,clus_max_id]<-1
  }
}

row_sum<-apply(res1,MARGIN = 1,sum)
res_norm1<-res1
for (i in 1:nrow(res1)){
  for (j in 1:ncol(res1)){
    if(row_sum[i]!=0){
      res_norm1[i,j]=res_norm1[i,j]/row_sum[i] #Normalizing to add up the probability to 1
    }
  }
}
train_new1<-cbind(train_org_du[,2],train_org_du[,1])
colnames(train_new1)<-c("Company_name","Cluster_id")
write.csv(train_new1,"updated_company_cluster_sample_v2.csv",row.names=F)
write.csv(res_norm1,"cluster_distribution_v2.csv",row.names = F)



#Solution-3 Modelling : FUTURE WORK
#train_fe$target<-train_org$Cluster_id
#x=train_fe
#y=as.factor(x$target)
#x$target=NULL

#PROBSVM
#library(probsvm)
#pr_svm<-probsvm(x, y, fold=5, kernel="linear", kparam=NULL, Inum=20, type="ovr", lambdas=2^(-10:10))
#pr<-predict(pr_svm,new.x=test_fe)
#pr$pred.prob
#rminer
