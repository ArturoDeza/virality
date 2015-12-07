clc; clear all; close all;

% In this script we will create all the split matrices for each attribute

%Load Attribute_Matrix

Attribute_Matrix = load('./Attribute_matrix.mat');
Attribute_Matrix = Attribute_Matrix.Attribute_matrix_spot;

% Load Attribute availability matrix:
Available_Attribute_Matrix = load('./Available_Attribute_Matrix.mat');
Available_Att_Matrix = Available_Attribute_Matrix.Available_Attribute_Matrix;

% Load pair matrices

pair_matrix = load('./pair_matrix.mat');
pair_matrix = pair_matrix.pair_matrix_spot;

virality_label = load('./virality_label.mat');
virality_label = virality_label.virality_label_spot;

Top_Pairs = load('./Top_Pairs.mat');
Top_Pairs = Top_Pairs.Top_Pairs;

% Columns are attributes
% First Row is Positive (+)
% Second Row is Negative (-)
% Third Row is Neutral (N)

%We will be using 80% of all the data, which is around 4000 images. 
%We will use exactly 4000 images for training, where a 80 - 20% of each of the +,-,N samples must be used for training/testing

Att_mat2 = Attribute_Matrix;
pair_matrix_exm = pair_matrix;

% Now go over all the image pairs from 1:4000 and create them into the split file

split_A1={};
split_A2={};
split_A3={};
split_A4={};
split_A5={};


%Get Split matrix:
%A_10 = [];
%for i = 1:10
%	A_10 = [A_10; 1:5039];
%end
%
%for i=1:10
%	if i<=9
%		A_10(i,:) = and(A_10(i,:)<=503*i,A_10(i,:)>=503*(i-1)+1);
%	else
%		A_10(i,:) = and(A_10(i,:)<=5039,A_10(i,:)>=503*(i-1)+1);
%	end
%end
%
%A_10 = ~A_10;

%Check to get the indexes of the top 250 pairs.
Top_250 = [];

indx_u_250 = NaN(length(Top_Pairs),1);

for i=1:length(Top_Pairs)
	indx_u1 = find(Top_Pairs(i)==pair_matrix(:,1));
	indx_u2 = find(Top_Pairs(i)==pair_matrix(:,2));

	if ~isempty(indx_u1)
		indx_u(i) = indx_u1;
	elseif ~isempty(indx_u2)
		indx_u(i) = indx_u2;
	else
		%Do nothing;
	end

	indx_u_250(i) = indx_u(i);
end

indx_u_250 = unique(indx_u_250);



%We are only going to do 1 split, and this will be the most disciminative 250 top pair split.

for k=1:1

	% Do 1st Attribute split
	
	split_A5{k}{1}.ClassName = './positive';
	split_A5{k}{2}.ClassName = './negative';
	split_A5{k}{3}.ClassName = './neutral';
	
	
	j_p_train = 1;
	j_n_train = 1;
	j_0_train = 1;
	
	j_p_test = 1;
	j_n_test = 1;
	j_0_test = 1;
	
	for i=1:5039
		%Create img 'ID'
		img_id = pair_matrix(i,1);
	
		%Create '.jpg' version of the pair.
		img_str = num2str(pair_matrix(i,1));
		img_str_jpg = strcat(img_str,'.jpg'); 	

		if sum(i==indx_u_250)==0 
		%if A_10(k,i)==1
			% If element is positive
			if Attribute_Matrix(i,5) == 1
				if virality_label(i) == 1
					split_A5{k}{1}.Training{j_p_train} = img_str_jpg;
					split_A5{k}{1}.TrainingID{j_p_train} = img_id;
					j_p_train = j_p_train + 1;
				elseif virality_label(i) == 0
					split_A5{k}{2}.Training{j_n_train} = img_str_jpg;
					split_A5{k}{2}.TrainingID{j_n_train} = img_id;
					j_n_train = j_n_train + 1;		
				else
					%Do nothing
				end
			
			%If element is negative
			elseif Attribute_Matrix(i,5) == -1
				if virality_label(i) == 1
					split_A5{k}{2}.Training{j_n_train} = img_str_jpg;
					split_A5{k}{2}.TrainingID{j_n_train} = img_id;
					j_n_train = j_n_train + 1;
				elseif virality_label(i) == 0
					split_A5{k}{1}.Training{j_p_train} = img_str_jpg;
					split_A5{k}{1}.TrainingID{j_p_train} = img_id;
					j_p_train = j_p_train + 1;
				else
					%Do nothing
				end

			%If element is neutral
			elseif Attribute_Matrix(i,5) == 0
				split_A5{k}{3}.Training{j_0_train} = img_str_jpg;
				split_A5{k}{3}.TrainingID{j_0_train} = img_id;
				j_0_train = j_0_train + 1;
	
			else
				continue;
			end
	
		else
			% If element is positive	
			if Attribute_Matrix(i,5) == 1
				if virality_label(i) == 1
					split_A5{k}{1}.Testing{j_p_test} = img_str_jpg;
					split_A5{k}{1}.TestingID{j_p_test} = img_id;
					j_p_test = j_p_test + 1;			
				elseif virality_label(i) == 0
					split_A5{k}{2}.Testing{j_n_test} = img_str_jpg;
					split_A5{k}{2}.TestingID{j_n_test} = img_id;
					j_n_test = j_n_test + 1;
				else
					%Do nothing
				end		

			% If element is negative
			elseif Attribute_Matrix(i,5) == -1
				if virality_label(i) == 1
					split_A5{k}{2}.Testing{j_n_test} = img_str_jpg;
					split_A5{k}{2}.TestingID{j_n_test} = img_id;
					j_n_test = j_n_test + 1;
				elseif virality_label(i) == 0
					split_A5{k}{1}.Testing{j_p_test} = img_str_jpg;
					split_A5{k}{1}.TestingID{j_p_test} = img_id;
					j_p_test = j_p_test + 1;
				else
					%Do nothing
				end
			% If element is neutral
			elseif Attribute_Matrix(i,5) == 0
				split_A5{k}{3}.Testing{j_0_test} = img_str_jpg;
				split_A5{k}{3}.TestingID{j_0_test} = img_id;
				j_0_test = j_0_test + 1;

			else
				continue;
			end
		end	
end

end

%Save split
split = split_A5;

%Notice that we are only doing 1 split.

%End of everything
save('./split_A5_Top.mat','split');
save('./sexual_N/split_A5_Top.mat','split');
