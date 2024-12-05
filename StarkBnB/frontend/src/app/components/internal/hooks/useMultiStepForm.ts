'use client'

import { ReactElement, useState } from "react";

const useMultiStepForm = (steps: ReactElement[]) => {
    const [currentStepIndex, setCurrentStepIndex] = useState(0)
    const isFirstStep = currentStepIndex === 0
    const isLastStep = currentStepIndex === steps.length - 1

    function next(){
        setCurrentStepIndex(i => {
            if (i >= steps.length - 1) return i
            return i + 1
        })
    }

    function back(){
        setCurrentStepIndex(i => {
            if (i <= 0) return i
            return i - 1
        })
    }

    function goto(index: number) {
        setCurrentStepIndex(index)
    }

    return {
        currentStepIndex, step: steps[currentStepIndex],
        goto, steps, next, back, isFirstStep, isLastStep
    }
}

export default useMultiStepForm;