
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: 
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements in your KB below in this section

%banking information for john and mary
hasAccount(john, cibc, 4000).
hasAccount(john, bmo, 8000).
hasAccount(mary, cibc, 5000).
hasAccount(mary, bmo, 2000).

% information about john and mary's activity
totalDeposits(john, cibc, 500).
totalDeposits(john, bmo, 2000).
totalDeposits(mary, cibc, 1500).
totalDeposits(mary, bmo, 1000).
totalWithdrawals(john, cibc, 1000).
totalWithdrawals(john, bmo, 1500).
totalWithdrawals(mary, cibc, 1000).
totalWithdrawals(mary, bmo, 3500).

%bank rates and minimum balance
monthlyRate(cibc, 0.005).   
monthlyRate(bmo, 0.008).
interestLevel(cibc, 500).
interestLevel(bmo, 1000).

%bank penalty
penalty(cibc, 20).
penalty(bmo, 50).

%%%%% SECTION: q2_rules
%%%%% Put statements for subtotal, accruedInterest, accruedPenalty, and endOfMonthBalance below.
%%%%% You may also put helper predicates here
%%%%% DO NOT PUT ATOMIC FACTS FOR hasAccount, totalDeposits, totalWithdrawals, monthlyRate, interestRate, or penalty below.

subtotal(Name, Bank, Subtotal) :- hasAccount(Name, Bank, Balance), totalDeposits(Name, Bank, Deposits), totalWithdrawals(Name, Bank, Withdrawals), Subtotal is Balance + Deposits - Withdrawals.

accuredInterest(Name, Bank, 0):- subtotal(Name, Bank, Subtotal), interestLevel(Bank, Level), Subtotal < Level.
accuredInterest(Name, Bank, I) :- subtotal(Name, Bank, Subtotal), interestLevel(Bank, Level), Subtotal >= Level, monthlyRate(Bank, Rate), I is Subtotal * Rate.

accuredPenalty(Name, Bank, 0) :- subtotal(Name, Bank, Subtotal), Subtotal >= 0.
accuredPenalty(Name, Bank, P) :- subtotal(Name, Bank, Subtotal), Subtotal < 0, penalty(Bank, P).

endOfMonthBalance(Name, Bank, Balance) :- subtotal(Name, Bank, Subtotal), accuredInterest(Name, Bank, I), accuredPenalty(Name, Bank, P), Balance is Subtotal + I - P.

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
