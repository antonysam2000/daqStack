resResolution = 25;

A = logspace(2,5,resResolution);
B = logspace(2,5,resResolution);
C = logspace(2,5,resResolution);

boardMax = 16;

vTest = zeros(resResolution^3,boardMax);

for n = 1:boardMax
    for a = 1:resResolution
        for b = 1:resResolution
            for c = 1:resResolution
                
                rBranch = B(b) + C(c);
                for k = 1:n
                    rBranch = (rBranch*C(c))/(rBranch+C(c));
                    rBranch = rBranch + B(b);
                end
                
                index = (a-1)*resResolution^2 + (b-1)*resResolution + c;
                vTest(index,n) = rBranch / (rBranch + A(a));
                
            end
        end
    end    
end

vLevel = 3.3;
vTest = vTest*vLevel;

slope = zeros(1,resResolution^3);

for k = 1:resResolution^3
    slope(1,k) = vTest(k,1) - vTest(k,end);
end

[maxSlope,index] = max(slope(:));

voltageSteps = vTest(index,:)
plot(linspace(1,boardMax,boardMax),vTest(index,:))
axis([1 boardMax 0 vLevel])

ResA = A(mod(floor(index/(resResolution^2)),resResolution) + 1)
ResB = B(mod(floor(index/resResolution),resResolution) + 1)
ResC = C(mod(index,resResolution) + 1)