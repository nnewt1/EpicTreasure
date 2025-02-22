bad=0
if !(pwn version  2>&1 | rg "Pwntools" 2>&1 >/dev/null); then
    echo pwntools 
   bad=1
fi
if !(seccomp-tools 2>&1 | rg "seccomp-tools" 2>&1 >/dev/null); then
    echo seccomp-tools 
   bad=1
fi
if !(ROPgadget  2>&1 | rg "Need a binary filename" 2>&1 >/dev/null); then
    echo ropgadget
   bad=1
fi
if !(strace  2>&1 | rg "Try 'strace -h'" 2>&1 >/dev/null); then
    echo strace
   bad=1
fi
if !(ltrace  2>&1 | rg "too few arguments" 2>&1 >/dev/null); then
    echo ltrace
   bad=1
fi
if !(rg --version 2>&1 | rg "ripgrep" 2>&1 >/dev/null); then
    echo ripgrep
   bad=1
fi
if !(one_gadget --help 2>&1 | rg "Usage: one_gadget " 2>&1 >/dev/null); then
    echo one_gadget
   bad=1
fi
if !(bash --version 2>&1 | rg "(4.4|5.0|5.1)" 2>&1 >/dev/null); then
    echo bash 
   bad=1
fi
if !(nc  2>&1 | rg "usage: nc" 2>&1 >/dev/null); then
    echo netcat
   bad=1
fi
if !(valgrind --version 2>&1 | rg "valgrind-" 2>&1 >/dev/null); then
    echo valgrind
   bad=1
fi
if !(gdb --version 2>&1 | rg "GNU gdb" 2>&1 >/dev/null); then
    echo gdb
   bad=1
fi
if !(patchelf --version 2>&1 | rg "patchelf" 2>&1 >/dev/null); then
    echo patchelf 
   bad=1
fi
if !(python3 -c "import tqdm" 2>&1); then
    echo tqdm 
   bad=1
fi
if [ $bad -eq 1 ]; then
	exit 1
fi

exit 0
