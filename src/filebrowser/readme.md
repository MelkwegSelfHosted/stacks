# Filebrowser stack


## Start and shutdown

```
sudo systemctl (start|stop) filebrowser
```

## Notes


Symlink the service file to the correct location
```
sudo ln -s filebrowser.service /etc/systemd/system/filebrowser.service
```

Enable the service
```
sudo systemctl enable filebrowser.service
```

Logs
```
sudo journalctl -u filebrowser.service
```

## References

https://askubuntu.com/questions/1459175/how-to-run-a-docker-compose-as-a-systemd-service
