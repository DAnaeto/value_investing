# Value Investing Assistant

_This project was made to assist in the act of value investing_

### Some things that this web application doesn't cover:

- What the business does, how the business makes money, etc.

- Competitive advantages for the stock compared to others in the same sector, aka moat (future addition)

- The management team behind the stock and their track record (underpromise & overdeliver or overpromise & underdeliver)

### This app does allow you to:

- Enter expected growth percentage yearly

- Enter discount percentage based on how the future values of the stock is valued in today's standards

- Enter margin of safety for that intrinsic value

## Docker Container

1. Install docker with [this guide](https://docs.docker.com/engine/install/fedora/ "the following guide")

2. Run the following lines of code in the terminal

- `sudo docker build -t value_investing .`
- `sudo docker run -it -p 3000:3000 value_investing`
