# Text-or-data detector

Neural Networks first experiments by Sergey Vasilyev. July 1997.

The neural network is trained based on the share of symbols in a text (0..100%).
Probably, only ASCII files are supported, as it was developed in the assumption 
that all letters are encoded as 0..255 (back then in 1997).


## Build

On Mac OS X, Free Pascal is needed:

```
brew install fpc
```

Then build both files:

```
fpc -Mtp -WM10.9 istext.pas
fpc -Mtp -WM10.9 train.pas
```

Check that they work:

```
$ ./train
Usage: Train.exe <text> <weights> <Y|N>

$ ./istext 
Usage: Test.exe <text> <weights>
```

## Train

Feed the text/data files into the network:

```
./train SOMEFILE.txt expr1 Y
./train SOMEFILE.bin expr1 N
```

Repeat as much as needed.


## Detect

```
./istext ANOTHERFILE.txt expr1
./istext ANOTHERFILE.bin expr1
```

There is a pretrained neural network in a file called `garry` — it can be used instead.

```
./istext ANOTHERFILE.txt garry
./istext ANOTHERFILE.bin garry
```
