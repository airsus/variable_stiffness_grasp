% グラフィックス用変数生成
function OUT = soft22_pos(IN)

% 第1指関節角度
q1		=	IN(1:2);

% 第2指関節角度
q2		=	IN(3:4);

% 対象物質量中心位置 & 姿勢角度
o		=	IN(5:7);

% 指先接触点位置
x1		=	IN(8:9);
x2		=	IN(10:11);

time	=	IN(12);

% リンク長さ
L11		=	0.070;
L12		=	0.055;

L21		=	0.070;
L22		=	0.055;

% 指先半径
r1	= 0.015;
r2	= 0.015;

% 対象物サイズ(縦×横) [m]
O_ver	= 0.049;
O_side	= 0.049;

% 指根元距離 [m]
D		= 0.10;

%%%%%%%%%%%%%%%%%%%% 第1指 %%%%%%%%%%%%%%%%%%%%
% 第1指第1関節位置
J11		=	[0.0; 0.0];

% 第1指第2関節位置
J12		=	[L11 * cos(q1(1)); L11 * sin(q1(1))];

% 第1指指先位置
J13		=	[L11 * cos(q1(1)) + L12 * cos(q1(1) + q1(2)); L11 * sin(q1(1)) + L12 * sin(q1(1) + q1(2))];

% 指先−第3関節位置(球にかからないようにするため)
Ja13	=	[L11 * cos(q1(1)) + (L12 - r1) * cos(q1(1) + q1(2)); L11 * sin(q1(1)) + (L12 - r1) * sin(q1(1) + q1(2))];

%%%%%%%%%%%%%%%%%%%% 第2指 %%%%%%%%%%%%%%%%%%%%
% 第2指第1関節位置
J21		=	[D; 0.0];

% 第2指第2関節位置
J22		=	[D + L21 * cos(q2(1)); L21 * sin(q2(1))];

% 第2指指先位置
J23		=	[D + L21 * cos(q2(1)) + L22 * cos(q2(1) + q2(2)); L21 * sin(q2(1)) + L22 * sin(q2(1) + q2(2))];

% 指先−第3関節位置(球にかからないようにするため)
Ja23	=	[D + L21 * cos(q2(1)) + (L22 - r2) * cos(q2(1) + q2(2)); L21 * sin(q2(1)) + (L22 - r2) * sin(q2(1) + q2(2))];

%%%%%%%%%%%%%%%%%%%% 対象物 %%%%%%%%%%%%%%%%%%%%
% 対象物各頂点位置
% 左上角
o1(1,1) = - O_side / 2.0;
o1(2,1) = - O_ver / 2.0;
% 左下角
o2(1,1) =   O_side / 2.0;
o2(2,1) = - O_ver / 2.0;
% 右下角
o3(1,1) =   O_side / 2.0;
o3(2,1) =   O_ver / 2.0;
% 右上角
o4(1,1) = - O_side / 2.0;
o4(2,1) =   O_ver / 2.0;

% 回転行列
R	 = [cos(o(3)), - sin(o(3));
		sin(o(3)),   cos(o(3))];

% 回転 + 並進移動
R_o1 = R * o1 + o(1:2, :);
R_o2 = R * o2 + o(1:2, :);
R_o3 = R * o3 + o(1:2, :);
R_o4 = R * o4 + o(1:2, :);

OUT = [J11' J12' J13' Ja13' J21' J22' J23' Ja23' R_o1' R_o2' R_o3' R_o4' x1' x2' o' q1' q2' time];
