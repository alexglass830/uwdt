unit inpout32;

interface
 function Inp32(PortAddress:byte):byte;stdcall;external 'inpout32.dll';
 procedure Out32(PortAddress:byte; data:byte);stdcall;external 'inpout32';

implementation

end.
 