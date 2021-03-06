clc; close all; clear all;

%Load split all splits!

split_A1 = load('../split_A1_Top.mat');
split_A2 = load('../split_A2_Top.mat');
split_A3 = load('../split_A3_Top.mat');
split_A4 = load('../split_A4_Top.mat');
split_A5 = load('../split_A5_Top.mat');

split_A1_IDs = [];
split_A2_IDs = [];
split_A3_IDs = [];
split_A4_IDs = [];
split_A5_IDs = [];

%Get unique Top 250 labels:
Top_250_unique = load('../unique_250.mat');
Top_250_unique = Top_250_unique.indx_u_250;

%Load pair matrix
pair_matrix = load('../pair_matrix.mat');
pair_matrix = pair_matrix.pair_matrix_spot;

virality_label = load('../virality_label.mat');
virality_label = virality_label.virality_label_spot;

for j=1:3
	for i=1:length(split_A1.split{1}{j}.TestingID)
		split_A1_IDs = [split_A1_IDs; split_A1.split{1}{j}.TestingID{i}];
	end
end

for j=1:3
	for i=1:length(split_A2.split{1}{j}.TestingID)
		split_A2_IDs = [split_A2_IDs; split_A2.split{1}{j}.TestingID{i}];
	end
end

for j=1:3
	for i=1:length(split_A3.split{1}{j}.TestingID)
		split_A3_IDs = [split_A3_IDs; split_A3.split{1}{j}.TestingID{i}];
	end
end

for j=1:3
	for i=1:length(split_A4.split{1}{j}.TestingID)
		split_A4_IDs = [split_A4_IDs; split_A4.split{1}{j}.TestingID{i}];
	end
end

for j=1:3
	for i=1:length(split_A5.split{1}{j}.TestingID)
		split_A5_IDs = [split_A5_IDs; split_A5.split{1}{j}.TestingID{i}];
	end
end


%Load  all result files:
%Load pairs for now:


%A1_hat = load('../animal_N/result_deep_dual_10_C1_G10/SVM_Result_0830_deep__split_01__kl1__weighted_F__bow_F__normalize_T__.mat');
%A2_hat = load('../synthgen_N/result_deep_dual_10_C01_G10/SVM_Result_1027_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
%A3_hat = load('../beautiful_N/result_deep_dual_10_C01_G10/SVM_Result_0553_deep__split_01__kl1__weighted_F__bow_F__normalize_T__.mat');
%A4_hat = load('../explicit_N/result_deep_dual_10_C10_G01/SVM_Result_0269_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
%A5_hat = load('../sexual_N/result_deep_dual_10_C10_G01/SVM_Result_0262_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');


% Select the SVM's that have the highest output per Attribute.
A1_hat = load('../animal_N/SVM_Result_0830_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
A2_hat = load('../synthgen_N/SVM_Result_1027_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
A3_hat = load('../beautiful_N/SVM_Result_0553_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
A4_hat = load('../explicit_N/SVM_Result_0269_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');
A5_hat = load('../sexual_N/SVM_Result_0262_deep__split_01__rbf__weighted_F__bow_F__normalize_T__.mat');

A1_hat = A1_hat.class_hat;
A2_hat = A2_hat.class_hat;
A3_hat = A3_hat.class_hat;
A4_hat = A4_hat.class_hat;
A5_hat = A5_hat.class_hat;

Attribute_pred_matrix = [];

pair_imgs = [];

for i=1:length(Top_250_unique)
%	img_buff = Top_250_unique(i);
%	
%	indx_L = find(img_buff==pair_matrix(:,1));
%	indx_R = find(img_buff==pair_matrix(:,2));
%
%	if isempty(indx_L)
%		img_buff = pair_matrix(indx_R,1);
%	end
%	
	img_buff = pair_matrix(Top_250_unique(i),1);

	pair_imgs(i) = img_buff;

	%Get indx per attribute of each image.

	indx1 = find(img_buff == split_A1_IDs);
	indx2 = find(img_buff == split_A2_IDs);
	indx3 = find(img_buff == split_A3_IDs);
	indx4 = find(img_buff == split_A4_IDs);
	indx5 = find(img_buff == split_A5_IDs);

	%Get attribute prediction.
	A1_pred = A1_hat(indx1);
	A2_pred = A2_hat(indx2);
	A3_pred = A3_hat(indx3);
	A4_pred = A4_hat(indx4);
	A5_pred = A5_hat(indx5);

%	%Standardize/Normalize predictions
%	if virality_label(Top_250_unique(i)) == 1
		A1_pred_norm = (1)*(A1_pred==1) + (-1)*(A1_pred==2) + (0)*(A1_pred==3);
		A2_pred_norm = (1)*(A2_pred==1) + (-1)*(A2_pred==2) + (0)*(A2_pred==3);
		A3_pred_norm = (1)*(A3_pred==1) + (-1)*(A3_pred==2) + (0)*(A3_pred==3);
		A4_pred_norm = (1)*(A4_pred==1) + (-1)*(A4_pred==2) + (0)*(A4_pred==3);
		A5_pred_norm = (1)*(A5_pred==1) + (-1)*(A5_pred==2) + (0)*(A5_pred==3);
%	elseif virality_label(Top_250_unique(i)) == 0
%		A1_pred_norm = (-1)*(A1_pred==1) + (1)*(A1_pred==2) + (0)*(A1_pred==3);
%		A2_pred_norm = (-1)*(A2_pred==1) + (1)*(A2_pred==2) + (0)*(A2_pred==3);
%		A3_pred_norm = (-1)*(A3_pred==1) + (1)*(A3_pred==2) + (0)*(A3_pred==3);
%		A4_pred_norm = (-1)*(A4_pred==1) + (1)*(A4_pred==2) + (0)*(A4_pred==3);
%		A5_pred_norm = (-1)*(A5_pred==1) + (1)*(A5_pred==2) + (0)*(A5_pred==3);
%	else
%		%Do nothing;
%	end

	Attribute_pred_matrix(i,:) = [A1_pred_norm A2_pred_norm A3_pred_norm A4_pred_norm A5_pred_norm];

end

Attribute_pred_matrix_S = [Attribute_pred_matrix(:,1) Attribute_pred_matrix(:,2) -Attribute_pred_matrix(:,3) Attribute_pred_matrix(:,4) -Attribute_pred_matrix(:,5)];

Acc_matrix = [];

%Run simulation 100 times

for kk=1:100

Attribute_pred_matrix_S2(:,1) = sum(Attribute_pred_matrix_S(:,1:1),2);
Attribute_pred_matrix_S2(:,2) = sum(Attribute_pred_matrix_S(:,1:2),2);
Attribute_pred_matrix_S2(:,3) = sum(Attribute_pred_matrix_S(:,1:3),2);
Attribute_pred_matrix_S2(:,4) = sum(Attribute_pred_matrix_S(:,1:4),2);
Attribute_pred_matrix_S2(:,5) = sum(Attribute_pred_matrix_S(:,1:5),2);

%Eliminate ties:
for i=1:5
	for j=1:length(Attribute_pred_matrix_S2(:,i));
		if Attribute_pred_matrix_S2(j,i)==0
			if rand>=0.5
				Attribute_pred_matrix_S2(j,i)=1;
			else
				Attribute_pred_matrix_S2(j,i)=-1;
			end
		end
	end
end

Acc1 = sum(Attribute_pred_matrix_S2(:,1)>=1)/sum(Attribute_pred_matrix_S2(:,1)~=0);
Acc2 = sum(Attribute_pred_matrix_S2(:,2)>=1)/sum(Attribute_pred_matrix_S2(:,2)~=0);
Acc3 = sum(Attribute_pred_matrix_S2(:,3)>=1)/sum(Attribute_pred_matrix_S2(:,3)~=0);
Acc4 = sum(Attribute_pred_matrix_S2(:,4)>=1)/sum(Attribute_pred_matrix_S2(:,4)~=0);
Acc5 = sum(Attribute_pred_matrix_S2(:,5)>=1)/sum(Attribute_pred_matrix_S2(:,5)~=0);

Acc_matrix = [Acc_matrix; [Acc1 Acc2 Acc3 Acc4 Acc5]];

disp(sum(Attribute_pred_matrix_S2(:,1)~=0));
disp(sum(Attribute_pred_matrix_S2(:,2)~=0));
disp(sum(Attribute_pred_matrix_S2(:,3)~=0));
disp(sum(Attribute_pred_matrix_S2(:,4)~=0));
disp(sum(Attribute_pred_matrix_S2(:,5)~=0));

end

%save('pair_imags.mat','pair_imgs');
%popularity_indxs = find(sum(Attribute_pred_matrix_S(:,1:5),2)~=0);
%save('popularity_indxs.mat','popularity_indxs');

%non_zero_indx = find(sum(Attribute_pred_matrix_S(:,1:5),2)~=0);
%save('non_zero_indx.mat','non_zero_indx');
