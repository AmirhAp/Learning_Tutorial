# logging
____________________________________________

## STEP 1: Logging Basics

**a good log should answer these questions:**
- when happend? 
- how serious? 
- where happend?
- what happend? 
_________________

### Basic Logger : (Logger V1)


```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


logger.info("hello world")
```

    INFO:__main__:hello world


### Logger Levels:


```python
logger.debug("Detailed developer info")
logger.info("Normal useful event")
logger.warning("Something suspicious happened")
logger.error("Something failed")
logger.critical("System is badly broken")
```

    INFO:__main__:Normal useful event
    WARNING:__main__:Something suspicious happened
    ERROR:__main__:Something failed
    CRITICAL:__main__:System is badly broken


______________

## STEP 2: Configuration

**target -> learn how to control logger**

### Core concepts:
- **formatter** --> how log look:
    2026-04-26 10:12:11 | INFO | app.services.person | Creating person 

- **handler** --> where log go:
    - console
    - file "app.log"
    - external system

- **logger** --> how is logging
    - each file has its own logger
    - all of them follow one global config
__________

### Basic Logger Config: 

**initail global config file : app/core/logging.py:**


```python
import logging

def init_logger():
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    formatter = logging.Formatter(
        "%(asctime)s | %(levelname)s | %(name)s | %(message)s"
    )

    #console handler:
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)

    #file handler:
    file_handler = logging.FileHandler("app.log")
    file_handler.setFormatter(formatter)

    logger.addHandler(console_handler)
    logger.addHandler(file_handler)
```

**we initail our logger in main.py:**


```python
init_logger()
```

**we use the logger in any level and file:**


```python
import logging

logger = logging.getLogger(__name__)

logger.info("hello")
```

    INFO:__main__:hello
    2026-05-23 17:09:49,041 | $(levelname)s | __main__ | hello
    2026-05-23 17:09:49,041 | INFO | __main__ | hello


_________

## STEP 3: Production Logging & Observability


