clc;close all;clear all;

kernel_buff = './kernel_deep_dual_10_C';
result_buff = './result_deep_dual_10_C';

for i=3:7
	for j=3:7
		switch i
			case 1
				C_buff = '00001';
			case 2
				C_buff = '0001';
			case 3 
				C_buff = '001';
			case 4
				C_buff = '01';
			case 5
				C_buff = '1';
			case 6
				C_buff = '10';
			case 7
				C_buff = '100';
			case 8
				C_buff = '1000';
			case 9
				C_buff = '10000';
			otherwise
				%Do nothing
		end

		switch j
			case 1
				G_buff = '00001';
			case 2
				G_buff = '0001';
			case 3
				G_buff = '001';
			case 4
				G_buff = '01';
			case 5
				G_buff = '1';
			case 6
				G_buff = '10';
			case 7
				G_buff = '100';
			case 8
				G_buff = '1000';
			case 9
				G_buff = '10000';
			otherwise
				%do nothing;
		end


	str_folder_kernel = strcat(kernel_buff,C_buff,'_G',G_buff);
	str_folder_result = strcat(result_buff,C_buff,'_G',G_buff);

	if ~exist(str_folder_kernel)
		mkdir(str_folder_kernel);
	else
		%Do nothing;
	end

	if ~exist(str_folder_result)
		mkdir(str_folder_result);
	else
		%Do nothing
	end


	end
end

