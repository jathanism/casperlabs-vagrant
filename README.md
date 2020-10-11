# Casperlabs Vagrant

This is intended to create a self-contained VM for use in Casper Labs contract development.

See: https://techspec.casperlabs.io/en/latest/dapp-dev-guide/index.html

# What Do

This assumes you have Vagrant and VirtualBox and that you're on a Mac. Run this to get them:

```
$ brew install vagrant
$ brew cask install virtualbox
```

Now
```
vagrant up --provider virtualbox
```

Once the system has provisioned.

```
vagrant ssh
```
