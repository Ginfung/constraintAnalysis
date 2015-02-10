% m = [-4:0.1:4];
% a = zeros(1,size(m,2));
% b = zeros(1,size(m,2));
% 
% for i = 1:size(m,2)
%     [a(i),b(i)] = Fonseca(m(i),1);
% end
% 
% plot(a,b);
% set(gca,'xlim',[-1 2]);
% set(gca,'ylim',[-1 2]);
% figure(gcf);
% hold on



% for i = 1:size(parent,1)
%     [parent(i,4),parent(i,5)] = Fonseca(parent(i,:),3);
% %     plot(r,t,'rx');
% end
% 
% for i = 1:size(parent,1)
%     plot(parent(i,4),parent(i,5),'rx');
%     hold on;
% end
% 
% m = zeros(3,2);
% count_m = 1;
% for a = -4:0.2:4
%     for b = -4:0.2:4
%         for c = -4:0.2:4
%             [m(count_m,1),m(count_m,2)] = Fonseca([a,b,c],3);
%             count_m = count_m+1;
%         end
%     end
% end
% 
% for i = 1:size(m,1)
%     plot(m(i,1),m(i,2),'o');
% end

% for i = 1:300
%     plot(parent(i,1),parent(i,2),'rx');
%     hold on;
% end
% set(gca,'xlim',[0 1]);
% set(gca,'ylim',[0 1]);
% figure(gcf);
% hold on

for i = 1:100
    plot(parent(i,1),parent(i,2),'rx');
    hold on;
end
 set(gca,'xlim',[0 1]);
 set(gca,'ylim',[0 1]);
 figure(gcf)
 hold on

