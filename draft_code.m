%% Tiny image formation for training

feats_tr{1} = getTinyImages(DS_1,true);
feats_tr{2} = getTinyImages(DS_2,true);
feats_tr{3} = getTinyImages(DS_3,true);
feats_tr{4} = getTinyImages(DS_4,true);
feats_tr{5} = getTinyImages(DS_5,true);
feats_tr{6} = getTinyImages(DS_6,true);
feats_tr{7} = getTinyImages(DS_7,true);
feats_tr{8} = getTinyImages(DS_8,true);
feats_tr{9} = getTinyImages(DS_9,true);
feats_tr{10} = getTinyImages(DS_10,true);
feats_tr{11} = getTinyImages(DS_11,true);
feats_tr{12} = getTinyImages(DS_12,true);
feats_tr{13} = getTinyImages(DS_13,true);
feats_tr{14} = getTinyImages(DS_14,true);
feats_tr{15} = getTinyImages(DS_15,true);

feats_tr = [feats_tr{1}; feats_tr{2}; feats_tr{3};...
    feats_tr{4}; feats_tr{5}; feats_tr{6};...
    feats_tr{7}; feats_tr{8}; feats_tr{9};...
    feats_tr{10}; feats_tr{11}; feats_tr{12};...
    feats_tr{13}; feats_tr{14}; feats_tr{15}];

%% Tiny image formation for testing

feats_ts{1} = getTinyImages(DS_1,false);
feats_ts{2} = getTinyImages(DS_2,false);
feats_ts{3} = getTinyImages(DS_3,false);
feats_ts{4} = getTinyImages(DS_4,false);
feats_ts{5} = getTinyImages(DS_5,false);
feats_ts{6} = getTinyImages(DS_6,false);
feats_ts{7} = getTinyImages(DS_7,false);
feats_ts{8} = getTinyImages(DS_8,false);
feats_ts{9} = getTinyImages(DS_9,false);
feats_ts{10} = getTinyImages(DS_10,false);
feats_ts{11} = getTinyImages(DS_11,false);
feats_ts{12} = getTinyImages(DS_12,false);
feats_ts{13} = getTinyImages(DS_13,false);
feats_ts{14} = getTinyImages(DS_14,false);
feats_ts{15} = getTinyImages(DS_15,false);

feats_ts = [feats_ts{1}; feats_ts{2}; feats_ts{3};...
    feats_ts{4}; feats_ts{5}; feats_ts{6};...
    feats_ts{7}; feats_ts{8}; feats_ts{9};...
    feats_ts{10}; feats_ts{11}; feats_ts{12};...
    feats_ts{13}; feats_ts{14}; feats_ts{15}];

%% Get everything set up

feats_all = [getTinyImages(DS_1);getTinyImages(DS_2);getTinyImages(DS_3);...
    getTinyImages(DS_4);getTinyImages(DS_5);getTinyImages(DS_6);...
    getTinyImages(DS_7);getTinyImages(DS_8);getTinyImages(DS_9);...
    getTinyImages(DS_10);getTinyImages(DS_11);getTinyImages(DS_12);...
    getTinyImages(DS_13);getTinyImages(DS_14);getTinyImages(DS_15)];