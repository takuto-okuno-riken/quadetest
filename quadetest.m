% nonparametric or rank analysis of covariance (Quade's test)
% Quade, D. (1967). Rank analysis of covariance. Journal of the American Statistical Association, 62(320), 1187-1200
% implementation is based on https://www.ibm.com/support/pages/can-spss-do-nonparametric-or-rank-analysis-covariance-quades-test

function [p,t,stats] = quadetest(y,x,group)
    % Rank the dependent variable and any covariates
    m = (size(y,1)+1) / 2;
    C = x;
    [R,Ti] = tiedrank(y);
    R = R - m;
    for i=1:size(x,2)
        [C(:,i),Ti] = tiedrank(x(:,i));
    end
    C = C - m;

    % linear regression of the ranks of the dependent variable on the ranks of the covariates
    [b,bint,r] = regress(R,C);
    
    % one-way analysis of variance (ANOVA), using the residuals from the regression
    [p,t,stats] = anova1(r,group);
end
