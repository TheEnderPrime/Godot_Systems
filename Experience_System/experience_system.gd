extends Node

# Player Experience Tracking
#	A variable to store the player’s current XP.
#	A way to increase XP (combat, quests, exploration, etc.).
#Level Tracking
#	A variable to store the player’s current level.
#	A mechanism to check if the player has reached the threshold for leveling up.
#Level Thresholds
#	A function or formula to determine how much XP is required for each level.
#	Common approaches:
#		Linear: XP_required = level * 100
#		Exponential: XP_required = 100 * (level ^ 2)
#		Custom curve: lookup table or curve resource.
#Level Up Logic
#When XP >= required XP:
#
#Increase level
#
#Reset or subtract required XP
#
#Recalculate XP needed for the next level
#
#Trigger level-up effects (animations, sound, UI update, stat increases)
#
#Feedback to Player
#
#UI to show:
#
#Current level
#
#Current XP
#
#XP required for next level (or progress bar)
