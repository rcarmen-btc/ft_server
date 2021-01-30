
.PHONY: build, run#, stop, clean, fclean

		# color output "Building"
		# build docker and save all logs in `build_logs` file
		# @docker build . --tag ft_server:a >build_logs
		# color output "Image built!"

build:
		@echo "$(FG_KHAKI)$(BUILDING)$(RE_COLOR)"
		@docker build -t ft_server . >build_logs
		@echo "$(BG_MEDIUM_SPRING_GREEN)$(FG_BLACK)$(BUILT)$(RE_COLOR)"
		@echo "$(FG_KHAKI)$(LOGS)$(RE_COLOR)"

run:
		docker run -it -p 80:80 -p 443:443 ft_server
		@echo "$(FG_KHAKI)Running...$(RE_COLOR)"
		@echo "$(BOLD)$(BG_PURPLE)$(FG_WHITE)$(RUN_SUCCESS)$(RE_COLOR)"

# OUTPUT SPECS
BUILT = " Image built! "
BUILDING = "Building please wait..."
LOGS = "Logs saved in 'building_logs' file"
RUN_SUCCESS = "Run success!"
BOLD = \033[1m
RE_COLOR = \033[0m

# BG COLORS
BG_PURPLE = \033[48;2;175;135;255m
BG_MINT = \033[48;2;72;209;204m
BG_GREEN = \033[48;2;0;208;145m
BG_KHAKI = \033[48;2;240;230;140m
BG_MEDIUM_SPRING_GREEN = \033[48;2;0;250;154m
BG_SPRING_GREEN = \033[48;2;0;255;127m

# FG COLORS
FG_WHITE = \033[38;2;255;255;255m
FG_BLACK = \033[38;2;0;0;0m
FG_GREEN = \033[32m
FG_TEST = \033[31m
FG_MEDIUM_SPRING_GREEN = \033[38;2;0;250;154m
FG_SPRING_GREEN = \033[38;2;0;255;127m
FG_KHAKI = \033[38;2;240;230;140m
FG_TURQUOISE = \033[38;2;64;224;208m
