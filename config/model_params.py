from scipy.stats import randint,uniform

# Model parameters for hyperparameter tuning
LIGHTGM_PARAMS={
    'n_estimators':randint(100,500),
    'max_depth' : randint(5,50),
    'learning_rate': uniform(0.01,0.2),
    'num_leaves': randint(20,100),
    'boosting_type' : ['gbdt' , 'dart' , 'goss']
}


RANDOM_SEARCH_PARAMS = {
    'n_iter' : 2, # Number of iterations for random search
    'cv' : 2, # Number of cross-validation folds
    'n_jobs':-1, # Use all available cores
    'verbose' :2, # Verbosity level
    'random_state' : 42, # Random seed for reproducibility
    'scoring' : 'accuracy' # Scoring metric for evaluation
}