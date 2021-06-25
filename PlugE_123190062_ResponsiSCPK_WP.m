%penyelesaian kasus menggunakan metode WP
clc;clear; %untuk membersihkan jendela command windows

%mengambil data yang diperlukan, yaitu: house age, distance to the nearest
%MRT station, number of convenience stores, house price of unit area
opts = detectImportOptions('Real estate valuation data set.xlsx'); 
opts1 = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = ([3:5,8]);
opts1.SelectedVariableNames = (1);
opts.DataRange = '2:51'; %mengambil data 1-50
opts1.DataRange = '2:51'; %mengambil data 1-50
inputX = readtable('Real estate valuation data set.xlsx', opts); %membaca data yang diperlukan untuk nilai x
nomor = readtable('Real estate valuation data set.xlsx', opts1); %membaca data yang diperlukan untuk nomor real estate
x = table2array(inputX); %data rating kecocokan dari masing-masing alternatif
no = table2cell(nomor); %data nomor real estate
k = [0,0,1,0];%atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
w = [3,5,4,1];%Nilai bobot tiap kriteria (1= sangat buruk, 2=buruk, 3= cukup, 4= tinggi, 5= sangat tinggi)

%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%tahapan ketiga, proses perangkingan
V= S/sum(S);

%proses mengurutkan rangking
V = V.';
V = num2cell(V);
hasil = {no,V};
hasil = horzcat(hasil{:});
hasilsort = sortrows(hasil, 2, 'descend');

%tampilan hasil
disp('Real estate yang menjadi alternatif terbaik untuk investasi jangka panjang = ');
disp('========================');
disp('|    No   |   Score   |');
disp('========================');
disp(hasilsort); %menampilkan hasil perangkingan
disp('========================');