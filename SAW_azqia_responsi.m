function varargout = SAW_azqia_responsi(varargin)
% SAW_AZQIA_RESPONSI MATLAB code for SAW_azqia_responsi.fig
%      SAW_AZQIA_RESPONSI, by itself, creates a new SAW_AZQIA_RESPONSI or raises the existing
%      singleton*.
%
%      H = SAW_AZQIA_RESPONSI returns the handle to a new SAW_AZQIA_RESPONSI or the handle to
%      the existing singleton*.
%
%      SAW_AZQIA_RESPONSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_AZQIA_RESPONSI.M with the given input arguments.
%
%      SAW_AZQIA_RESPONSI('Property','Value',...) creates a new SAW_AZQIA_RESPONSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_azqia_responsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_azqia_responsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_azqia_responsi

% Last Modified by GUIDE v2.5 25-Jun-2021 20:49:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_azqia_responsi_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_azqia_responsi_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SAW_azqia_responsi is made visible.
function SAW_azqia_responsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_azqia_responsi (see VARARGIN)

% Choose default command line output for SAW_azqia_responsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_azqia_responsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_azqia_responsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = [0.3, 0.2, 0.23, 0.1, 0.07, 0.1];%pembobotan
k = [0,1,1,1,1,1];%cost/benefit
x = xlsread('dataRumah.xlsx','C2:H1011');%membaca data dengan batasan tersebut

%TAHAP PERTAMA
[m,n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x
R=zeros (m,n); %mmebuat matrix R(kosong)

%statement untuk kriteria dengan atribut keuntungan
for j=1:n
    if k(j)==1
        R(:,j)= x(:,j)./max(x(:,j));
    else
        R(:,j)= min(x(:,j))./x(:,j);
    end
end

%perangkingan
for i=1:m
    V(i)= sum(w.*R(i,:));
end
rank = sort(V,'descend');

%perangkingan 20 alternatif terbaik
for i=1:20
    hasil(i) = rank(i);
end

opts2 = detectImportOptions('dataRumah.xlsx'); 
opts2.SelectedVariableNames = [2]; %kolom nama rumah

namaRumah = readmatrix('dataRumah.xlsx',opts2);

for i=1:20
 for j=1:m
   if(hasil(i) == V(j))
    seleksi(i) = namaRumah(j);
    break
   end
 end
end

seleksi = seleksi';

set(handles.tabelHasil, 'data', seleksi); 



% --- Executes on button press in tampilData.
function tampilData_Callback(hObject, eventdata, handles)

%untuk menampilkan nilai
opts = detectImportOptions('dataRumah.xlsx');
opts.SelectedVariableNames = [3,4,5,6,7,8];%ambil kolom 3-8
data = readmatrix('dataRumah.xlsx',opts);%membaca file dengan syarat opts tersebut
set(handles.tabelData,'data',data);

% hObject    handle to tampilData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clearData.
function clearData_Callback(hObject, eventdata, handles)
% hObject    handle to clearData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.tabelData,'data','');
