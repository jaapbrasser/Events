function Verb-Noun($a,$b){$a|%{do-something{$a + $b|?{$_-eq'something'}}|
select *|sort -desc|ft -au}}