function [u]=two_dir_alloc_mch(v_D, v_C,u,p_limits,v_limits)% 
% (c) mengchaoheng
% Last edited 2019-11
% B=[-0.5   0       0.5   0;
%      0  -0.5    0       0.5;
%     0.25   0.25   0.25   0.25];
global B
v=v_D+v_C;
if(~v_limits)
    umin=[1;1;1;1]*(-p_limits)*pi/180;
    umax=[1;1;1;1]*p_limits*pi/180;
else
%====��ֵ���ٶ�Լ��================ 
    umin=max([1;1;1;1]*(-p_limits)*pi/180,-0.01*400*pi/180+u);
    umax=min([1;1;1;1]*p_limits*pi/180,0.01*400*pi/180+u);
end
% uv = dir_alloc_mch(v,umin,umax); % wls_alloc_mch(v,u);% �ȼ���������������
uv =wls_alloc_mch(v, u,p_limits, v_limits);
if(check(uv,p_limits,v_limits)) % ����������������ֱ������
    u=uv;
else  % �����ټ����Ŷ�����
%     uv1 = dir_alloc_mch(v_D,umin,umax); % wls_alloc_mch(v1,u);
    uv1 =wls_alloc_mch(v_D,u, p_limits, v_limits);
    if(check(uv1,p_limits,v_limits))  % ���Ŷ������㣬�����ز������㣬��������η���
        
        umin1=umin-uv1;
        umax1=umax-uv1;
        
%         uv2 = dir_alloc_mch(v_C,umin1,umax1);
        [uv2,~] = dir_alloc(B,v_C,umin1,umax1);
          
        u=uv1+uv2;
    else  % �Ŷ�Ҳ�������㣬��ֱ�Ӱ��պ����ؽ��з���
        u=uv1;
    end
end
