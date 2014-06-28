function f = GetResponseviaUSB(PM)
    N = 64;
    tt=['',PM.Buffer];
	uN = uint32(N);
    v1 = libpointer('cstring',tt);
	v2 = libpointer('uint32Ptr',uN);
    C = libpointer('uint32Ptr',uN);
	[A B C] = calllib('usbdll','newp_usb_get_ascii',PM.usbAddress,v1,uN,v2);
    if numel(B)==0
        f = 'No Data Recieved.';
        return;
    else
        x = N;
        for i = 1:N
            if B(i)==char(13)
                x = i-1;
                break;
            end
        end
    f=B(1:x);
    return;
    end
    f = 'No Data Returned';
end