# rdkb-log-extractor

author: Terry Yu

brief: collect log from rdk-b based system

github: https://github.com/TUNGHUAYU/rdkb-log-extractor

[toc]

## Layout

The following content list all shell scripts in this project:

```bash
.
├── extract_rdkb_snapshot.sh	# compress data model and rdklogs and push 
├── get_DataModel.sh			# get data model (DM)
├── get_rdklogs.sh				# get rdklogs data 
├── readme.md					# this document
└── tftp_macro_function.sh		# macro function of tftp

0 directories, 5 files
```



## workflow



Hardware Layout

```mermaid
flowchart LR
	PC:::unit <--"telnet"--> DUT:::unit
	
	classDef unit fill:transparent,stroke:#000,stroke-width:2px
```



Sequence Diagram

```mermaid
sequenceDiagram
	autonumber
	participant PC
	participant DUT
	
	PC ->> PC: Setup <br> tftp server
	
	DUT ->> PC: (tftp) Get
	Note over PC, DUT: request "tftp_macro_function.sh"
    Note over PC, DUT: request "get_DataModel.sh"
    Note over PC, DUT: request "get_rdklogs.sh"
    Note over PC, DUT: request "extract_rdkb_snapshot.sh"
    
    PC ->> DUT: (tftp) Get - Reply
	Note over PC, DUT: send "tftp_macro_function.sh"
    Note over PC, DUT: send "get_DataModel.sh"
    Note over PC, DUT: send "get_rdklogs.sh"
    Note over PC, DUT: send "extract_rdkb_snapshot.sh"
    
    DUT ->> DUT: Import <br> tftp macro functions
    Note over DUT, DUT: $ source "tftp_macro_function.sh"
    Note over DUT, DUT: tftp_fetch <file1> <file2> ...
    Note over DUT, DUT: tftp_push <file1> <file2> ...
    
    DUT ->> DUT: Dump, Push <br> Snapshot
    Note over DUT, DUT: $ bash extract_rdkb_snapshot.sh <condition>
    Note over DUT, DUT: $ bash extract_rdkb_snapshot.sh test

    DUT ->> PC: Dump, Push <br> Snapshot zip file
    Note over DUT, PC: Push test_snapshot.tar.gz
    
```



