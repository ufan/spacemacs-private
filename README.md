# My Spacemacs Private directory

## Install
  * clone into the .emacs.d/private directory
  * rm the original .spacemacs file under home directory
  * create a new link of .spacemacs to the .spacemacs in the private directory.
    Assuming you are in the home directory, then the command should be as follows:
      `ln .emacs.d/private/.spacemacs .spacemacs` 
  That will be all!
  
## Description ##
  * private: the customized layers I use myself, which is not included by the official spacemacs release
  * snippets: customized code snippets I use myself with yasnippet syntax
  * templates: customized file templates I use myself with yatemplate as backend and yasnippet as syntax
  * local: some customized packages , which can be downloaded from the ELPA repository
  
