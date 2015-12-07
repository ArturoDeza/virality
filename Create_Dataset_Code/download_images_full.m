%unique ID

clc;clear all; close all;

D=csvread('img_id.csv');
[junk,index] = unique(D,'first');  
D1=D(sort(index));

%folder='../redditHtmlData/';

Img_hash=textread('img_hash.csv','%s','whitespace',',');

total_unique_num=length(D1);

file_storage='./image_urls2.csv';
fid=fopen(file_storage,'w');

url_vector={};

for i=1:total_unique_num
%for i=1:100
%for i=1:20
	index=min(find(D1(i)==D));
	file_name=Img_hash(index);
	file_address=strcat(folder,file_name);
	file_address=strcat(file_address,'.html');

	M=fileread(file_address{1});
	m1=strfind(M,'href="http://imgur.com');
	m2=strfind(M,'href="http://i.imgur.com');
	m3=strfind(M,'href="http://www.imgur.com');
	m4=strfind(M,'href="http://www.i.imgur.com');

	m_title=strfind(M,'<a class="title "');

	%m5=strfind(M,'href="https://imgur.com');
	%m6=strfind(M,'href="https://i.imgur.com');
	%m7=strfind(M,'href="https://www.imgur.com');
	%m8=strfind(M,'href="https://www.i.imgur.com');

	%logo=strfind(M,'previous logo');
	m_test=[m1 m2 m3 m4];

	if isempty(m_test)
		continue;
	else
		m_temp=sort([m1 m2 m3 m4 m_title]);
		indexator=find(sort([m1 m2 m3 m4 m_title])==m_title);
		if (indexator==length(m_temp))
			continue;
		else
			m_min=m_temp(indexator+1);

			z=strfind(M,'"');
			aux=find(z>m_min);
			aux1=aux(1);
			aux2=aux(2);
			%disp(m_min-m_title);
			%if (z(aux1)-m_min~=5)
			if (m_min-m_title~=18)
				continue;
			else
				url=M(z(aux1)+1:z(aux2)-1);
				url_vector{end+1}=url;
				if isempty(strfind(url,'/a/')) && isempty(strfind(url,'.gif')) && isempty(strfind(url,'.html'))
					if ~(isempty(strfind(url,'.jpg')) && isempty(strfind(url,'.jpeg')) && isempty(strfind(url,'.png')) && isempty(strfind(url,'.gif')))
						img_name=num2str(i);
						img_name_mod=strcat('./reddit_images_full2/',img_name);
						[filestr, url_status] = urlwrite(url,img_name_mod);
						fprintf(fid,url);fprintf(fid,'\n');
					else
						url=strcat(url,'.jpg');	
						img_name=num2str(i);
						img_name_mod=strcat('./reddit_images_full2/',img_name);
						[filestr, url_status] = urlwrite(url,img_name_mod);
						fprintf(fid,url);fprintf(fid,'\n');				
					end
				else
					continue;
				end
				url_vector{end+1}=url;
				clear file_name
			end
		end
	end
	if rem(i,100)==0
		i_str=num2str(i);
		i_str=strcat(i_str,'/16736');
		disp(i_str);
	end
end
