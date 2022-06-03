## Usage

--------------------

```
xov [OPTIONS] [FILE]
```

### Options:

* `-e [editor]` - programm to edit file
* `-l` - load from remote repository
* `-u` - upload to remote repository

Default filename is `date +%y-%m-%d`

### To change remote URL and use your own repository:

```
git remote set-url origin {URL}
```

## Notes

--------------------

You can put link to `xov` in `/bin` directory and use it globaly.
But you can't use `xov.sh` globaly.