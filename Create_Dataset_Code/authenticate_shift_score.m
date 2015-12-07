%normalize scores for each image

shift_score=csvread('shift_global_score.csv');
subreddit_total=textread('subreddit.csv','%s','delimiter','\n');
subreddit_selection=textread('subreddit_hour_shift_mean_global.csv','%s','delimiter',';');
hour_time=csvread('hour_time.csv');
subreddit_categories=textread('subreddit_categories.csv','%s','delimiter','\n');


file_storage='./authenticated_shift_score.csv';
fid=fopen(file_storage,'w');

score_norm=[];

for j=1:867
	subreddit_xx=subreddit_categories(j);
	index1{j}=find(ismember(subreddit_selection,subreddit_xx));
	index2(j)=min(index1{j});
end

valueSet = index2;
keySet = subreddit_categories;
mapObj = containers.Map(keySet,valueSet);

for i=1:132307
	subreddit_buff=subreddit_total(i);
	hour_buff=hour_time(i);
	index=mapObj(subreddit_buff{1});
	subreddit_mean_cell_time=subreddit_selection(index(1)+3*(hour_buff)+2);	
	subreddit_mean_str=subreddit_mean_cell_time{1};
	subreddit_mean_num=str2num(subreddit_mean_str);

	score_aux=shift_score(i)/subreddit_mean_num;

	fprintf(fid,'%s\n',num2str(score_aux));
	if rem(i,1000)==0
		display_counter=strcat(num2str(i),'/132307');
		disp(display_counter);
	end	
end
