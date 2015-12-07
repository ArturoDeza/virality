%final image names:

A=dir('./reddit_images_full4');

file_storage='./final_names.csv';
fid=fopen(file_storage,'w');

for i=1:length(A)-2
	name=A(i+2).name;
	fprintf(fid,'%s\n',name);
end
