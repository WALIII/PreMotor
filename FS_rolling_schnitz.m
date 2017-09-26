function FS_rolling_schnitz(data)

[indX,B,C] = FS_schnitz(data)

    lo = -0.5;
    hi = 0.5;

    
Dat = data.undirected;
counter = 1;
figure(); 
for i = 1; 
    subplot(3,4,counter);
    imagesc(normc(squeeze(Dat(i,:,indX)))'); 
    imagesc(C);

    title('AVG (UNDIRECTED)');
     subplot(3,4,counter+1);
    imagesc(normc(squeeze(Dat(i+1,:,indX)))'); 
     subplot(3,4,counter+2);
    imagesc(normc(squeeze(Dat(i+2,:,indX)))'); 
     subplot(3,4,counter+3);
    imagesc(normc(squeeze(Dat(i+3,:,indX)))');
    

     subplot(3,4,counter+4);
    imagesc(normc(squeeze(Dat(i+4,:,indX)))'); 
     subplot(3,4,counter+5);
    imagesc(normc(squeeze(Dat(i+5,:,indX)))'); 
     subplot(3,4,counter+6);
    imagesc(normc(squeeze(Dat(i+6,:,indX)))');

     subplot(3,4,counter+7); 
    imagesc(normc(squeeze(Dat(i+7,:,indX)))'); 
     subplot(3,4,counter+8);
    imagesc(normc(squeeze(Dat(i+8,:,indX)))'); 
     subplot(3,4,counter+9);
    imagesc(normc(squeeze(Dat(i+9,:,indX)))');
   
     subplot(3,4,counter+10);
    imagesc(normc(squeeze(Dat(i+10,:,indX)))'); 
     subplot(3,4,counter+11);
    imagesc(normc(squeeze(Dat(i+11,:,indX)))');
    
 
end

Dat = data.directed;

counter = 1;
figure(); 
for i = 1; 
    subplot(3,4,counter);
    imagesc(normc(squeeze(Dat(i,:,indX)))');
    imagesc(B);
    title('AVG (DIRECTED)');
     subplot(3,4,counter+1);
    imagesc(normc(squeeze(Dat(i+1,:,indX)))'); 
     subplot(3,4,counter+2);
    imagesc(normc(squeeze(Dat(i+2,:,indX)))'); 
     subplot(3,4,counter+3);
    imagesc(normc(squeeze(Dat(i+3,:,indX)))');
    

     subplot(3,4,counter+4);
    imagesc(normc(squeeze(Dat(i+4,:,indX)))'); 
     subplot(3,4,counter+5);
    imagesc(normc(squeeze(Dat(i+5,:,indX)))'); 
     subplot(3,4,counter+6);
    imagesc(normc(squeeze(Dat(i+6,:,indX)))');

     subplot(3,4,counter+7); 
    imagesc(normc(squeeze(Dat(i+7,:,indX)))'); 
     subplot(3,4,counter+8);
    imagesc(normc(squeeze(Dat(i+8,:,indX)))'); 
     subplot(3,4,counter+9);
    imagesc(normc(squeeze(Dat(i+9,:,indX)))');
   
     subplot(3,4,counter+10);
    imagesc(normc(squeeze(Dat(i+10,:,indX)))'); 
     subplot(3,4,counter+11);
    imagesc(normc(squeeze(Dat(i+11,:,indX)))');
    
 
end
