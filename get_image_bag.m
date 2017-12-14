clear;
load bag800_4;
load DS;

field = 'DS';
values = {DS_1; DS_2; DS_3; DS_4; DS_5; DS_6; DS_7; DS_8; DS_9; DS_10; DS_11; DS_12; DS_13; DS_14; DS_15};
D = struct(field,values);

number_classes = 15;

for i=1:number_classes    
    class = readall(D(i).DS);
    DS_bag_i = [];
    for k=1:length(class)
        image = im2double(class{k});
        imageBag = encode(bag, image);
        DS_bag_i = [DS_bag_i; imageBag];
    end
    DS_bag{i} = DS_bag_i;
    clearvars DS_bag_i;
end