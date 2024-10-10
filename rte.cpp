ALGORITHM 5.1 Reduce-to-Elegance
Reduction_Signal
reduce_to_elegance (Node ^current, Set *dominant_set, Set *command_set)
{
    Node *child;
    Node *grandchild;
    Set *handle_set;
    Set *local_command_set;
    Reduction_Signal outcome;

    if (the current_s type is AND) {
        /* APPLY REDUNDANT TO CURRENT, IF POSSIBLE */
        current->guard_set = set_difference(current->guard_set, dominant_set);
        
        /* APPLY lCCSUBTRACT TO CURRENT, IF POSSIBLE */
        current->guard_set = set_difference(current->guard_set, command_set);
        
        /* DETERMINE IF CURRENT IS A SITE FOR OSUBSUME */
        if (current has no children && current->guard_set is empty) {
            return DISCONNECT;
        }
        
        /* DETERMINE IF CURRENT IS A SITE FOR 1SUBSUME */
        result_set = set_intersection(current->guard_set, command_set);
        if (result_set is not empty) {
            return DELETE;
        }
        
        /* REPEAT UNTIL CURRENT->GUARD_SET DOES NOT CHANGE DURING THE LOOP */
        do {
            /* REMEMBER THE CURRENT VALUE OF CURRENT->GUARD_SET */
            previous_guard_set = current->guard_set;
            
            /* DETERMINE IF CURRENT IS A SITE FOR INCONHANDLE */
            handle_set = set_union(dominant_set, current->guard_set);
            if (handle_set is inconsistent) {
                return DELETE;
            }
            
            /* REDUCE EACH CHILD’S SUBTREE TO RELATIVE ELEGANCE */
            for (each child in current_s list of children) {
                /* REDUCE CHILD’S SUBTREE TO RELATIVE ELEGANCE */
                outcome = reduce_to_elegance(child, handle_set, command_set);
                
                /* HANDLE THE RESULT OF REDUCING CHILD’S SUBTREE TO RELATIVE ELEGANCE */
                switch (outcome) {
                    case DELETE:
                        release the tree rooted at current;
                        return DELETE;
                    
                    case DISCONNECT:
                        remove child from current_s list of children;
                        release the tree rooted at child;
                        advance the child pointer to current_s next child;
                        break;
                    
                    case KEEP:
                        /* APPLY PROMOTE TO CHILD, IF POSSIBLE */
                        result_set = intersection of the guard sets of all of child_s children;
                        if (result_set is not empty) {
                            current->guard_set = set_union(current->guard_set, result_set);
                            for (each grandchild in child_s list of children) {
                                grandchild->guard_set = set_difference(grandchild->guard_set, result_set);
                            }
                            
                            /* APPLY AND-CUT TO EACH OF CHILD’S CHILDREN, IF POSSIBLE */
                            for (each grandchild in child_s list of children) {
                                if (grandchild has one child && grandchild->guard_set is empty) {
                                    add grandchild_s child_s children to child_s list of children;
                                    release grandchild->first_child;
                                    release grandchild;
                                }
                            }
                            
                            /* SINCE AT LEAST ONE NEW CONSTRAINT HAS BEEN ADDED TO CURRENT’S GUARD_SET, REPROCESS ALL OF CURRENT’S CHILDREN */
                            reset the child pointer to current->first_child;
                        } else {
                            /* APPLY AND-CUT TO EACH OF CHILD’S CHILDREN, IF POSSIBLE */
                            for (each grandchild in child_s list of children) {
                                if (grandchild has one child && grandchild->guard_set is empty) {
                                    add grandchild_s child_s children to child_s list of children;
                                    release grandchild->first_child;
                                    release grandchild;
                                }
                            }
                            
                            /* IF ANY TERMINAL, SINGLE-CONSTRAINT AND NODE WAS ADOPTED AS A GRANDCHILD BY CURRENT, PREPARE TO REPROCESS CHILD; OTHERWISE, PREPARE TO PROCESS THE NEXT CHILD, IF ANY */
                            if (no terminal AND node whose guard set contains one constraint was adopted as a grandchild by current) {
                                advance the child pointer to current_s next child;
                            }
                        }
                }
            }
            
            /* APPLY OR-CUT TO EACH CHILD OF CURRENT, IF POSSIBLE */
            for (each child in current_s list of children) {
                if (child has only one child) {
                    grandchild = child->first_child;
                    current->guard_set = set_union(current->guard_set, grandchild->guard_set);
                    add all of grandchild_s children to current_s list of children;
                    release child;
                    release grandchild;
                }
            }
        } while (current->guard_set is not equal to previous_guard_set);

        /* DETERMINE IF CURRENT IS A SITE FOR O-SUBSUMPTION */
        if (current has no children && current->guard_set is empty) {
            return DISCONNECT;
        }
        return KEEP;
    }
    else /* CURRENT’S TYPE IS OR */ {
        for (each child in current_s list of children) {
            /* CONSTRUCT THE COMMAND SET FOR CHILD */
            local_command_set = command_set;
            for (each sibling of child) {
                if (sibling is a terminal, single-constraint AND node) {
                    add sibling_s constraint to local_command_set;
                }
            }
            
            /* REDUCE EACH CHILD’S SUBTREE TO RELATIVE ELEGANCE */
            outcome = reduce_to_elegance(child, dominant_set, local_command_set);
            
            /* HANDLE THE RESULT OF REDUCING CHILD’S SUBTREE TO RELATIVE ELEGANCE */
            switch (outcome) {
                case DELETE:
                    if (current has more than one child) {
                        remove child from current_s list of children;
                        release child_s subtree;
                        advance the child pointer to current_s next child;
                    } else {
                        return DELETE;
                    }
                    break;
                    
                case DISCONNECT:
                    return DISCONNECT;
                    
                case KEEP:
                    advance the child pointer to current_s next child;
            }
        }
        return KEEP;
    }
}
