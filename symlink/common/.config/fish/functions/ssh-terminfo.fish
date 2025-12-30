function ssh-terminfo
    infocmp | ssh "$argv" tic -
end
