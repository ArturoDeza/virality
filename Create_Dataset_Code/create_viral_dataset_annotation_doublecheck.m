close all; clear all; clc;

img_score=csvread('authenticated_shift_score.csv');
raw_score=csvread('img_score.csv');
comment_score=csvread('img_comments.csv');
M=textread('final_names.csv','%s','whitespace',',');

img_id=csvread('img_id.csv');

img_subreddit=textread('subreddit.csv','%s','delimiter',';');

num_elements=length(M);

popular_subreddits={'funny', 'WTF', 'aww', 'athiesm', 'gaming'};

subreddit_categories={
'funny',
'WTF',
'aww',
'atheism',
'gaming',
'pics',
'gifs',
'GifSound',
'AdviceAnimals',
'reactiongifs',
'reddit.com',
'gif',
'trees',
'fffffffuuuuuuuuuuuu',
'woahdude',
'photoshopbattles',
'4chan',
'space',
'pokemon',
'HIFW'};

img_data_score=[];

D=csvread('img_id.csv');
[junk,index] = unique(D,'first');  
D1=D(sort(index));

all_scores=[];
raw_scores=[];


for i=1:num_elements
%for i=1:100
	aux=M(i);
	num_aux=str2num(aux{1});
	pointer=D1(num_aux);
	X=find(pointer==img_id);
	img_score_vec=[];
	raw_score_vec = []; %Added for CVPR Camera
	comment_score_vec = []; %Added for CVPR Camera.
	virality_vec=zeros(2,length(X));
	raw_virality_vec = zeros(2,length(X)); %Added for CVPR Camera.
	comment_virality_vec = zeros(2,length(X)); %Added for CVPR Camera.
	subreddit_score_bin=zeros(1,length(subreddit_categories));
	total_entries=length(X);
	counter=0;
	for j=X(1):X(end)
		counter=counter + 1;
		index=find(ismember(subreddit_categories,img_subreddit(j)));
		if isempty(index)
			virality_vec(1,counter)=0;
			virality_vec(2,counter)=-1;
			raw_virality_vec(1,counter)=0;%Added for Camera CVPR
			raw_virality_vec(2,counter)=-1;%Added for Camera CVPR
			comment_virality_vec(1,counter)=0;
			comment_virality_vec(2,counter)=-1;
			continue;
		else
			subreddit_score_bin(index)=subreddit_score_bin(index)+1;
			virality_vec(1,counter)=img_score(j);
			virality_vec(2,counter)=index;
			raw_virality_vec(1,counter)=raw_score(j);%Added for Camera CVPR
			raw_virality_vec(2,counter)=index;%Added for Camera CVPR
			comment_virality_vec(1,counter)=comment_score(j);
			comment_virality_vec(2,counter)=index;
		end
	end
	total_number_index=length(find(subreddit_score_bin~=0));

	virality_median_sub=[];
	raw_virality_median_sub=[]; %Added for Camera CVPR
	comment_virality_median_sub=[];


	for j=1:length(subreddit_categories)
		if subreddit_score_bin(j)~=0
			virality_median_sub=[virality_median_sub; virality_vec(1,find(virality_vec(2,:)==j))'];
			raw_virality_median_sub = [raw_virality_median_sub; raw_virality_vec(1,find(raw_virality_vec(2,:)==j))'];%Added for Camera CVPR
			comment_virality_median_sub = [comment_virality_median_sub; comment_virality_vec(1,find(comment_virality_vec(2,:)==j))']; %Added fro Camera CVPR;
		end
	end

	if isempty(virality_median_sub)
		continue;
	end

	all_scores=[all_scores;virality_median_sub];

	%Get the max scores.
	%virality_median_sub_2=max(virality_median_sub);
	%semi-original:mean
	%virality_median_sub_2=mean(virality_median_sub);
	%Original: median
	%virality_median_sub_2=median(virality_median_sub);
	%New alternative High - median
%	virality_median_sub_2=max(virality_median_sub)-median(virality_median_sub);
	%New alternative High - mean
	%virality_median_sub_2=max(virality_median_sub)-mean(virality_median_sub);

	virality_mean_sub_2=mean(virality_median_sub);
	virality_max_sub_2=max(virality_median_sub);

	virality_max_raw = max(raw_virality_median_sub); %Added for CVPR version
	comment_max = max(comment_virality_median_sub); %Added for CVPR version

%	for j=1:length(subreddit_categories)
%		if subreddit_score_bin(j)~=0
%			virality_median_sub=[virality_median_sub; [median(virality_vec(1,find(virality_vec(2,:)==j))) j]];
%
%		end
%	end
	
	%img_median_score=[img_median_score; num_aux virality_median_sub_2];
	img_data_score=[img_data_score;num_aux virality_max_sub_2 virality_mean_sub_2 length(virality_median_sub) virality_max_raw comment_max];

end

data_sci=img_data_score;
mean_max=mean(img_data_score(:,2));
mean_reps=mean(img_data_score(:,4));
data_sci(:,7)=data_sci(:,2).*log(data_sci(:,4)/mean_reps);%.*sign(log(data_sci(:,4)/mean_reps));
%data_sci(:,5)=data_sci(:,2).*log(data_sci(:,4));%.*sign(log(data_sci(:,4)/mean_reps));

%data_sci(:,7) = data_sci(:,2);

%img_median_score_sort=sortrows(data_sci,2);

img_median_score_sort=sortrows(data_sci, 7);

img_file_template = 'http://brie.uchicago.edu/ftp-www/Viral_total/';

viral_dataset={};

for i=1:10078
	img_id_buff = num2str(img_median_score_sort(i,1));
	img_add_total = strcat(img_file_template,img_id_buff,'.jpg');
	viral_dataset{i}.img_id = img_median_score_sort(i,1);
	viral_dataset{i}.img_link = img_add_total;
	viral_dataset{i}.SNAP_id = D1(img_median_score_sort(i,1));
	viral_dataset{i}.v_score = img_median_score_sort(i,7);
	viral_dataset{i}.max_a_score = img_median_score_sort(i,2);
	viral_dataset{i}.mean_a_score = img_median_score_sort(i,3);
	viral_dataset{i}.submissions = img_median_score_sort(i,4);
	viral_dataset{i}.max_raw_upvotes = img_median_score_sort(i,5);
	viral_dataset{i}.max_number_of_comments = img_median_score_sort(i,6); 
	disp(i);
end

save('viral_datasetV2.mat','viral_dataset');
